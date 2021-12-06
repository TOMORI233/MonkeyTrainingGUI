function CueIntegrationStiFcn(device)
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
    DTO.vars.trialStartFlag = false;
    DTO.vars.oddballType = [];

    %% Save DTO to device userdata and enable serialport callback
    set(device, 'UserData', DTO);
    configureCallback(device, 'byte', 1, DTO.callbackFcn);

    %% Set TDT device obj
%     DTO.obj = [];
    DTO.obj = TDEV();
    DTO.obj.standby;
    pause(2);
    DTO.obj.record;
    % DTO.obj.preview;
    DTO.obj.DEVICE_NAME = DTO.obj.DEVICE_NAMES{1};

    %% Initialize TDT constant params
    % DTO.obj.write('waterDelay', waterDelayTimeDev);

    %% Set timer
    delete(timerfind);
    DTO.period = 0.02; % sec
    set(device, 'UserData', DTO);
    mTimer = timer('TimerFcn', {@mTimerFcn, device}, 'Period', DTO.period, 'ExecutionMode', 'fixedRate');
    start(mTimer);
end

%% TimerFcn
function mTimerFcn(~, ~, device)
    %% Get constants and variables
    DTO = get(device, 'UserData');
    period = DTO.period * 1000; % ms
    obj = DTO.obj;
    % Constant parameters
    paramsNames = fieldnames(DTO.params);

    for index = 1:size(paramsNames, 1)
        eval([paramsNames{index}, '=DTO.params.', paramsNames{index}, ';']);
    end

    % Variables
    varsNames = fieldnames(DTO.vars);

    for index = 1:size(varsNames, 1)
        eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
    end

    %% Idle
    if sweepCount > sweepCountMax
        disp('Reach max sweep count');
        obj.idle;
        configureCallback(device, 'off');
        delete(timerfind);
    end

    %% TODO: Stimulus
    tCount = tCount + 1;

    % Punish for not starting, for ACTIVE
    if tCount >= max([lastStiOnsetTime, pushTime]) + punishDelayTime * 1000 / period
        obj.write('T', 1); % Punishment On
    end

    % Trial started by monkey
    if ~trialStartFlag && pushAfterDelayFlag && tCount >= pushTime + pushToOnsetInterval / period
        sweepCount = sweepCount + 1;
        % Reset flags
        pushInTrialFlag = false;
        pushAfterDelayFlag = false;
        stiCount = 0;

        % Generate oddball sequence
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

        % determine sequence
        freqSeq = [ones(1, stdNum) * frequencyStd, frequencyDev];
        intensitySeq = [ones(1, stdNum) * intensityStd, intensityDev];
        attSeq = CalAttenuation(stiPosition, soundType, freqSeq, intensitySeq, intensityFile);
        % durSeq = [ones(1, stdNum) * durationStd, durationDev];

        % Set flags
        trialStartFlag = true;

        disp(['Trial Start - ' num2str(sweepCount)]);
        disp([cueType, ' ', oddballType, ' ', num2str(stdNum)]);
    end

    % Std trial correct
    if trialStartFlag && stiCount == stdNum + 1 && tCount >= lastStiOnsetTime + waterDelayTimeStd / period && strcmp(oddballType, 'STD') && ~pushInTrialFlag
        obj.write('W', rewardTimeCorrect);
        obj.write('water', 1);
        obj.write('water', 0);
        disp('std correct');
        trialStartFlag = false;
    end

    % TODO: Present stimuli
    if trialStartFlag && tCount >= lastStiOnsetTime + ISI / period && stiCount <= stdNum
        stiCount = stiCount + 1;
        lastStiOnsetTime = tCount;
        obj.write('sweep', sweepCount);

        switch soundType
            case 'pureTone'
                obj.write('freq', freqSeq(stiCount));
            case 'complexTone'
                obj.write('freq', freqSeq(stiCount));
                obj.write('freq2', freqSeq(stiCount) * 0.5);
                obj.write('freq3', freqSeq(stiCount) * 0.25);
                obj.write('freq4', freqSeq(stiCount) * 2);
                obj.write('freq5', freqSeq(stiCount) * 0.125);
                obj.write('freq6', freqSeq(stiCount) * 4);
                obj.write('freq7', freqSeq(stiCount) * 1/16);
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

    % Trial auto end
    if trialStartFlag && stiCount >= stdNum + 1 && tCount > lastStiOnsetTime + max([waterDelayTimeStd choiceWindow(2)]) / period
        trialStartFlag = false;
    end

    %% Update DTO for serialport callbacFcn
    for index = 1:size(varsNames, 1)
        DTO.vars.(varsNames{index}) = eval(varsNames{index});
    end

    set(device, 'UserData', DTO); % Save DTO to device userdata
    configureCallback(device, 'byte', 1, DTO.callbackFcn); % Enable serialport callback
end
