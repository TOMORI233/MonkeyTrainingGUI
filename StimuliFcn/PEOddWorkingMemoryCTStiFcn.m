function PEOddWorkingMemoryCTStiFcn(device)
%% Variables initialization
DTO = get(device, 'UserData');
DTO.vars.attSeq = [];
DTO.vars.cueType = [];
DTO.vars.freqSeq = [];
DTO.vars.ISISeq = 0;
DTO.vars.intensityFile = LoadIntensityFile(DTO.params.stiPosition, DTO.params.soundType);
DTO.vars.intensitySeq = [];
DTO.vars.ISI = DTO.params.ISI_average;
DTO.vars.lastStiOnsetTime = 0;
DTO.vars.pushInTrialFlag = false;
DTO.vars.pushAfterDelayFlag = true;
DTO.vars.pushTime = 0;
DTO.vars.stdNum = 0;
DTO.vars.stiCount = 0;
DTO.vars.sweepCount = 0;
DTO.vars.tCount = 0;
DTO.vars.trialStartFlag = false;
DTO.vars.oddballType = [];
DTO.vars.oddballType = [];
DTO.vars.addSweepCount = 0;
%% Initialize TDT constant params
% DTO.obj.write('waterDelay', waterDelayTimeDev);
% Constant parameters
paramsNames = fieldnames(DTO.params);

for index = 1:size(paramsNames, 1)
    eval([paramsNames{index}, '=DTO.params.', paramsNames{index}, ';']);
end

%% Save DTO to device userdata and enable serialport callback
set(device, 'UserData', DTO);
if offsetChoiceWinFlag
    DTO.callbackFcn = @OffsetChoiceWinlSerialFcn;
end
configureCallback(device, 'byte', 1, DTO.callbackFcn);


% read Variables
varsNames = fieldnames(DTO.vars);

for index = 1:size(varsNames, 1)
    eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
end



% pause(2);
%% Set TDT device obj
%     DTO.obj = [];
DTO.obj = TDEV();
DTO.obj.DEVICE_NAME = DTO.obj.DEVICE_NAMES{1};
DTO.obj.standby;
pause(2);

%% Set timer
delete(timerfind);
DTO.period = 0.01; % sec
DTO.vars.sessionStart = tic;
mTimer = timer('TimerFcn', {@mTimerFcn, device}, 'Period', DTO.period, 'ExecutionMode', 'fixedRate');
set(device, 'UserData', DTO);
start(mTimer);
DTO.obj.record;
% DTO.obj.preview;

end

%% TimerFcn
function mTimerFcn(~, ~, device)
%% Get constants and variables
DTO = get(device, 'UserData');
period = DTO.period * 1000; % ms
obj = DTO.obj;


paramsNames = fieldnames(DTO.params);

for index = 1:size(paramsNames, 1)
    eval([paramsNames{index}, '=DTO.params.', paramsNames{index}, ';']);
end

% Variables
varsNames = fieldnames(DTO.vars);

for index = 1:size(varsNames, 1)
    eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
end

%% TODO: Stimulus
% tCount = tCount + 1; % period = 0.02;
tCount = toc(sessionStart) / DTO.period; % period = 0.02;
% time2LastSound = toc*1000 -firstOnset2LastOnset;

% Punish for not starting, for ACTIVE
if tCount >= max([lastStiOnsetTime, pushTime]) + punishDelayTime * 1000 / period
    obj.write('T', 1); % Punishment On
end

% Trial started by monkey
if ~trialStartFlag && pushAfterDelayFlag && tCount >= pushTime + pushToOnsetInterval / period
    sweepCount = sweepCount + 1;
    % Idle
    if sweepCount > sweepCountMax + addSweepCount
        disp('Reach max sweep count');
        obj.idle;
        configureCallback(device, 'off');
        delete(timerfind);
    end
    % time to devonset
    obj.write('waterDelay', waterDelayTimeDev);
    % Reset flags
    pushInTrialFlag = false;
    pushAfterDelayFlag = false;
    stiCount = 0;

    % Generate oddball sequence
    % parameters of current trial
    stdNum = randsrc(1, 1, [stdNumArray'; stdNumProb']); % Random std number based on stdNumProb

    % cue type (cue integration protocol used only)
    cueTypeStr = {'freq', 'location', 'double'};
    cueType = cueTypeStr{randsrc(1, 1, [[1 2 3]; [freqTrialRatio locationTrialRatio doubleTrialRatio] / 100])};
    nCueType = length(find([freqTrialRatio locationTrialRatio doubleTrialRatio] ~= 0));

    % std freq
    if randomStdFreqFlag
        frequencyStd = (200 + randperm(100, 1)) * 16;
    end

    % std location
    locationStd = 0;

    % difference level

    % Calibration of prob for used cueType
    pControl = 1 / ((1 / freqDiffProb(1) - 1) * nCueType + 1);
    diffProb = [pControl; (1 - pControl) * freqDiffProb(2:end) / (1 - freqDiffProb(1))];
    diffLevel = randsrc(1, 1, [0:(length(diffProb) - 1); diffProb']);

    % dev freq
    if strcmp(freqIncOrDec, 'freqInc')
        frequencyDev = frequencyStd * freqBaseDiffRatio^diffLevel;
    else
        frequencyDev = frequencyStd / freqBaseDiffRatio^diffLevel;
    end

    % dev intensity
    intensityDev = intensityStd;

    % dev location
    if locationNum ~= length(diffProb) % location number should be same as number of frequency
        locationNum = length(diffProb);
    end
    locationDev = diffLevel; % the diff level of location and frequency should be same

    % TODO: dev duration
    % durationDev = durationStd;

    % TODO: random ISI


    % TODO: random position
    %

    % determine oddball trial type
    oddballType = 'DEV';


    switch cueType
        case 'freq'
            locationDev = locationStd;

            if frequencyDev == frequencyStd
                oddballType = 'STD';
            end

        case 'location'
            frequencyDev = frequencyStd;

            if locationDev == locationStd
                oddballType = 'STD';
            end

        case 'double'


            if frequencyDev == frequencyStd && locationDev == locationStd
                oddballType = 'STD';
            end

    end



    % reverse STD and DEV
    if fixedDevFlag
        frequencyStdDev = [frequencyStd ^ 2 / frequencyDev, frequencyStd];
    else
        frequencyStdDev = [frequencyStd, frequencyDev];
    end

    % determine sequence
    freqSeq = [ones(1, stdNum) * frequencyStdDev(1), frequencyStdDev(2)];
    intensitySeq = [ones(1, stdNum) * intensityStd, intensityDev];
    attSeq = CalAttenuation(stiPosition, soundType, freqSeq, intensitySeq, intensityFile);
    ISISeq = [0, ones(1, stdNum-1) * ISI_average, lastStdToDev, 0];
    % durSeq = [ones(1, stdNum) * durationStd, durationDev];

    % Set flags
    trialStartFlag = true;

    disp(['Trial Start - ' num2str(sweepCount)]);
    disp([cueType, ' ', oddballType, ' ', num2str(stdNum)]);
end




% TODO: Present stimuli
if trialStartFlag && tCount >= lastStiOnsetTime + ISISeq(stiCount + 1) / period && stiCount <= stdNum
    stiCount = stiCount + 1;
    lastStiOnsetTime = tCount;
    obj.write('sweep', sweepCount);

    switch soundType
        case 'pureTone'
            obj.write('freq', freqSeq(stiCount));
        case 'complexTone'
            obj.write('freq', freqSeq(stiCount));
        case 'noise'

    end

    disp([soundType, ': ', num2str(stiCount)]);
    disp(['freq: ', num2str(freqSeq(stiCount)), ' att: ', num2str(attSeq(stiCount))]);

    obj.write('att', attSeq(stiCount));
    obj.write('Dur', intensitySeq(stiCount));
    obj.write('num', stiCount);
    obj.write('trig', 1);
    obj.write('trig', 0);
end


% Std trial correct
if trialStartFlag && stiCount == stdNum + 1 && tCount >= lastStiOnsetTime + waterDelayTimeStd / period && strcmp(oddballType, 'STD') && ~pushInTrialFlag
    obj.write('W', rewardTimeCorrect);
    obj.write('water', 1);
    obj.write('water', 0);
    disp('std correct');
    trialStartFlag = false;
end


% Trial auto end
if trialStartFlag && stiCount >= stdNum + 1 && tCount > lastStiOnsetTime  + max( offsetChoiceWinFlag * durationStd + [waterDelayTimeStd choiceWindow(2)]) / period

    %     disp('trial auto end');
    trialStartFlag = false;
end


% passive initiate next trial
if strcmp(activeOrPassive,'passiveBehavior') && ~trialStartFlag &&  tCount > lastStiOnsetTime + delayTime / period
    %      disp('passive trial auto start');
    pushAfterDelayFlag = 1;
    pushTime = tCount - pushToOnsetInterval / period;
end

%% Update DTO for serialport callbacFcn
for index = 1:size(varsNames, 1)
    DTO.vars.(varsNames{index}) = eval(varsNames{index});
end

set(device, 'UserData', DTO); % Save DTO to device userdata
configureCallback(device, 'byte', 1, DTO.callbackFcn); % Enable serialport callback
end
