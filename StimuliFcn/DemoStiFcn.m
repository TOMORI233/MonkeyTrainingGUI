function DemoStiFcn(device)
    %% TODO: Variables initialization
    DTO = get(device, 'UserData');
    DTO.vars.attSeq = [];
    DTO.vars.cueType = [];
    DTO.vars.durationSeq = [];
    DTO.vars.freqSeq = [];
    DTO.vars.intensityFile = LoadIntensityFile(DTO.params.stiPosition, DTO.params.soundType);
    DTO.vars.intensitySeq = [];
    DTO.vars.ISI = DTO.params.ISI_average;
    DTO.vars.lastStiOnsetTime = 0;
    DTO.vars.mDurationDev = 0; % Real dev duration applied to one specific trial
    DTO.vars.mDurationStd = 0; % Real std duration applied to one specific trial
    DTO.vars.mFrequencyDev = 0; % Real dev freq applied to one specific trial
    DTO.vars.mFrequencyStd = 0; % Real std freq applied to one specific trial
    DTO.vars.mIntensityDev = 0; % Real dev intensity applied to one specific trial
    DTO.vars.mIntensityStd = 0; % Real std intensity applied to one specific trial
    DTO.vars.oddballType = []; % 'STD' or 'DEV'
    DTO.vars.pushInTrialFlag = false;
    DTO.vars.pushAfterDelayFlag = true;
    DTO.vars.pushTime = 0;
    DTO.vars.stdNum = 0;
    DTO.vars.stiCount = 0;
    DTO.vars.sweepCount = 0;
    DTO.vars.tCount = 0;
    DTO.vars.trialStartFlag = false;

    %% Save DTO to device userdata and enable serialport callback
    set(device, 'UserData', DTO);
    configureCallback(device, 'byte', 1, DTO.callbackFcn);

    %% Set TDT device obj
    DTO.obj = []; % For Test Only
    % DTO.obj = TDEV();
    % DTO.obj.standby;
    % pause(2);
    % DTO.obj.record;
    % % DTO.obj.preview;
    % DTO.obj.DEVICE_NAME = DTO.obj.DEVICE_NAMES{1};

    %% TODO: Initialize TDT constant params
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
    % if tCount >= max([lastStiOnsetTime, pushTime]) + punishDelayTime * 1000 / period
    %     obj.write('T', 1); % Punishment On
    % end

    % Trial started by monkey
    if ~trialStartFlag && pushAfterDelayFlag && tCount >= pushTime + pushToOnsetInterval / period
        sweepCount = sweepCount + 1;
        % Reset flags
        pushInTrialFlag = false;
        pushAfterDelayFlag = false;
        stiCount = 0;

        % Generate oddball sequence
        % TODO: std number
        stdNum = randsrc(1, 1, [stdNumArray'; stdNumProb']); % Random std number based on stdNumProb

        % TODO: cue type (cue integration protocol)
        cueTypeStr = {'freq', 'intensity', 'double'};
        cueType = cueTypeStr{randsrc(1, 1, [[1 2 3]; [freqTrialRatio intensityTrialRatio doubleTrialRatio] / 100])};
        nCueType = length(find([freqTrialRatio intensityTrialRatio doubleTrialRatio] ~= 0));

        % TODO: difference level
        % diffProb = freqDiffProb;
        % Calibration of prob for used cueType
        pControl = 1 / ((1 / freqDiffProb(1) - 1) * nCueType + 1);
        diffProb = [pControl; (1 - pControl) * freqDiffProb(2:end) / (1 - freqDiffProb(1))];
        diffLevel = randsrc(1, 1, [0:(length(diffProb) - 1); diffProb']);

        % TODO: std freq
        if randomStdFreqFlag
            mFrequencyStd = (200 + randperm(100, 1)) * 16;
        else
            mFrequencyStd = frequencyStd;
        end

        % TODO: dev freq
        if strcmp(freqIncOrDec, 'freqInc')
            mFrequencyDev = mFrequencyStd * freqBaseDiffRatio^diffLevel;
        else
            mFrequencyDev = mFrequencyStd / freqBaseDiffRatio^diffLevel;
        end

        % TODO: std intensity
        mIntensityStd = intensityStd;

        % TODO: dev intensity
        if fixedDevIntensityFlag
            mIntensityDev = intensityStd;

            if strcmp(intensityIncOrDec, 'intensityDec')
                mIntensityStd = mIntensityDev + intensityMinDiff * diffLevel;
            else
                mIntensityStd = mIntensityDev - intensityMinDiff * diffLevel;
            end

        else

            if strcmp(intensityIncOrDec, 'intensityInc')
                mIntensityDev = mIntensityStd + intensityMinDiff * diffLevel;
            else
                mIntensityDev = mIntensityStd - intensityMinDiff * diffLevel;
            end

        end

        % TODO: std duration
        mDurationStd = durationStd;

        % TODO: dev duration
        mDurationDev = mDurationStd;
        % if strcmp(durationIncOrDec, 'durationInc')
        %     mDurationDev = mDurationStd * durBaseDiffRatio^diffLevel;
        % else
        %     mDurationDev = mDurationStd / durBaseDiffRatio^diffLevel;
        % end

        % TODO: random ISI
        ISI = ISI_average;

        % TODO: random position

        % TODO: determine oddball trial type
        oddballType = 'DEV';

        switch cueType
            case 'freq'
                mIntensityDev = mIntensityStd;

                if mFrequencyDev == mFrequencyStd
                    oddballType = 'STD';
                end

            case 'intensity'
                mFrequencyDev = mFrequencyStd;

                if mIntensityDev == mIntensityStd
                    oddballType = 'STD';
                end

            case 'double'

                if mFrequencyDev == mFrequencyStd && mIntensityDev == mIntensityStd
                    oddballType = 'STD';
                end

        end

        % TODO: determine sequence
        freqSeq = [ones(1, stdNum) * mFrequencyStd, mFrequencyDev];
        intensitySeq = [ones(1, stdNum) * mIntensityStd, mIntensityDev];
        attSeq = CalAttenuation(stiPosition, soundType, freqSeq, intensitySeq, intensityFile);
        durationSeq = [ones(1, stdNum) * mDurationStd, mDurationDev];

        % Set flags
        trialStartFlag = true;

        disp(['Trial Start - ' num2str(sweepCount)]);
        disp([soundType, ' ', cueType, ' ', oddballType, ' ', num2str(stdNum)]);
    end

    % Std trial correct
    if trialStartFlag && stiCount == stdNum + 1 && tCount >= lastStiOnsetTime + waterDelayTimeStd / period && strcmp(oddballType, 'STD') && ~pushInTrialFlag
        % obj.write('W', rewardTimeCorrect);
        % obj.write('water', 1);
        % obj.write('water', 0);
        trialStartFlag = false;

        disp('std correct');
    end

    % TODO: Present stimuli
    if trialStartFlag && tCount >= lastStiOnsetTime + ISI / period && stiCount <= stdNum
        stiCount = stiCount + 1;
        lastStiOnsetTime = tCount;

        % TODO
        switch soundType
            case 'pureTone'
                % obj.write('freq', freqSeq(stiCount));
            case 'complexTone'

            case 'noise'

        end

        % TODO
        % obj.write('sweep', sweepCount);
        % obj.write('att', attSeq(stiCount));
        % obj.write('Dur', intensitySeq(stiCount));
        % obj.write('num', stiCount);
        % obj.write('trig', 1);
        % obj.write('trig', 0);

        disp([num2str(stiCount), ': freq - ', num2str(freqSeq(stiCount)), '    att - ', num2str(attSeq(stiCount))]);
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
