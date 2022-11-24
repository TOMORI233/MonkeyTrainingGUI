function PEOddBasicCTStiFcn(device)
%% Variables initialization
DTO = get(device, 'UserData');
DTO.vars.attSeq = [];
DTO.vars.cueType = [];
DTO.vars.freqSeq = [];
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
DTO.vars.time2LastSound = 0;
DTO.vars.trialStartFlag = false;
DTO.vars.oddballType = [];
DTO.vars.oddballType = [];
DTO.vars.firstOnset2LastOnset = 0;
DTO.vars.time2LastSound = 0;
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

%% Generate oddball sequence
params.freq = [];
params.Int = [];
params.att = [];
params.num = [];
params.ISI = [];
oddballTypeAll = [];
soundNum = [];

% read Variables
varsNames = fieldnames(DTO.vars);

for index = 1:size(varsNames, 1)
    eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
end

for trialN = 1:sweepCountMax*2
    % std number
    stdNum = randsrc(1, 1, [stdNumArray'; stdNumProb']);

    % cue type (cue integration protocol used only)
    cueTypeStr = {'freq', 'intensity', 'double'};
    cueType = cueTypeStr{randsrc(1, 1, [[1 2 3]; [freqTrialRatio intensityTrialRatio doubleTrialRatio] / 100])};
    nCueType = length(find([freqTrialRatio intensityTrialRatio doubleTrialRatio] ~= 0));

    % std freq
    if randomStdFreqFlag
        frequencyStd = (200 + randperm(100, 1)) * 16;
    end

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
    if strcmp(intensityIncOrDec, 'intensityInc')
        intensityDev = intensityStd + intensityMinDiff * diffLevel;
    else
        intensityDev = intensityStd - intensityMinDiff * diffLevel;
    end

    % TODO: dev duration
    % durationDev = durationStd;

    % TODO: random ISI
    ISI = ISI_average;

    % TODO: random position
    %

    % determine oddball trial type
    oddballType = 'DEV';

    switch cueType
        case 'freq'
            intensityDev = intensityStd;

            if frequencyDev == frequencyStd
                oddballType = 'STD';
            end

        case 'intensity'
            frequencyDev = frequencyStd;

            if intensityDev == intensityStd
                oddballType = 'STD';
            end

        case 'double'

            if frequencyDev == frequencyStd && intensityDev == intensityStd
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
    % durSeq = [ones(1, stdNum) * durationStd, durationDev];

    % integrate stim parameters
    params.freq = [params.freq ; freqSeq'];
    params.Int = [params.Int ; intensitySeq'];
    params.att = [params.att ; reshape(attSeq,[length(attSeq),1])];
    params.num = [params.num ; (1:stdNum+1)'];
    params.ISI = [params.ISI ; ones(stdNum+1,1)*ISI];

    oddballTypeAll = [oddballTypeAll ; {oddballType}];
    soundNum = [soundNum ; stdNum+1];

end
params.soundNum = soundNum;
DTO.vars.oddballTypeAll = oddballTypeAll;
DTO.vars.soundNum = soundNum;
DTO.vars.ISIAll = params.ISI;

path = 'D:\Monkey\matlab\parameters';
generateParamsFiles(path,params);

% pause(2);
%% Set TDT device obj
%     DTO.obj = [];
DTO.obj = TDEV();
DTO.obj.DEVICE_NAME = DTO.obj.DEVICE_NAMES{2};
DTO.obj.standby;
pause(2);

%% Set timer
delete(timerfind);
DTO.period = 0.02; % sec
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
time2LastSound = toc*1000 -firstOnset2LastOnset;
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
    if sweepCount == 1
        obj.write('waterDelay', waterDelayTimeDev);
        idx = 1: (soundNum(1)-1);
    else
        idx = (1:soundNum(sweepCount)-1) + sum(soundNum(1 : sweepCount - 1));
    end

    firstOnset2LastOnset = sum(ISIAll(idx));

    % Reset flags
    pushInTrialFlag = false;
    pushAfterDelayFlag = false;
    stiCount = 0;

    % parameters of current trial
    oddballType = oddballTypeAll{sweepCount};
    stdNum = soundNum(sweepCount) - 1;

    % Set flags
    trialStartFlag = true;
    
    
       switch soundType
            case 'pureTone'

            case 'complexTone'

            case 'noise'

       end
        obj.write('sweep', sweepCount);
        obj.write('trig', 1);
        obj.write('trig', 0);
        tic

    %     disp(['Trial Start - ' num2str(sweepCount)]);
    %     disp([cueType, ' ', oddballType, ' ', num2str(stdNum)]);
end

% trig current trial
%         obj.write('sweep', sweepCount);
if trialStartFlag && tCount >= lastStiOnsetTime + ISI / period && stiCount <= stdNum
    stiCount = stiCount + 1;
    %       disp([soundType, ': ', num2str(stiCount)]);

    %       disp(['stdNum = ' num2str(stdNum)]);
    %       disp(['trialStartFlag' num2str(trialStartFlag)]);
    %       disp(['stiCount = ' num2str(stiCount)]);
    %       disp(['current tCount = ' num2str(tCount)]);
    %       disp(['next sti time = ' num2str( lastStiOnsetTime + ISI / period)]);
    lastStiOnsetTime = tCount;

end
% if stiCount == stdNum + 1
%     toc
% end

% Std trial correct
% std water time uncorrect, add ISI 20220520
if trialStartFlag && stiCount == stdNum + 1 && time2LastSound >=   waterDelayTimeStd - waterDelayTimeDev && strcmp(oddballType, 'STD') && ~pushInTrialFlag

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
