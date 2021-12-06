function GeneralSerialFcn(device, ~)
    %% Read 1 byte data from serialport
    res = read(device, 1, 'uint8');
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

    %% TODO
    if ~isempty(res) && res(1) == 1
        disp('push - rising edge');

        %% Punishment off
        obj.write('T', 0);

        %% Trial started by monkey (Used when rising egde detected only)
        % if ~trialStartFlag && tCount >= max([lastStiOnsetTime pushTime]) + delayTime / period
        %     pushAfterDelayFlag = true;
        % end
        % pushTime = tCount;

        %% Novelty detection
        if trialStartFlag
            pushInTrialFlag = true;

            if stiCount <= stdNum
                % interruption
                disp('interrupt');
                obj.write('error', 1);
                sweepCount = sweepCount - 1;
            else
                % dev correct
                if tCount >= lastStiOnsetTime + choiceWindow(1) / period && tCount <= lastStiOnsetTime + choiceWindow(2) / period && strcmp(oddballType, 'DEV')
                    disp('dev correct');
                    obj.write('W', rewardTimeCorrect);
                    obj.write('water', 1);
                    obj.write('water', 0);
                end

            end
            
            trialStartFlag = false;
        end

        obj.write('push', 1);
        obj.write('push', 0);
        obj.write('error', 0);

        flush(device);
    end

    if ~isempty(res) && res(1) == 2
        disp('push - falling edge');

        %% Trial started by monkey
        if ~trialStartFlag && tCount >= max([lastStiOnsetTime pushTime]) + delayTime / period
            pushAfterDelayFlag = true;
        end

        pushTime = tCount;
        obj.write('push', 1);
        obj.write('push', 0);

        flush(device);
    end

    %% Update DTO
    for index = 1:size(varsNames, 1)
        DTO.vars.(varsNames{index}) = eval(varsNames{index});
    end

    set(device, 'UserData', DTO); % Save DTO to device userdata
end
