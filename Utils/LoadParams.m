function paramsLoad = LoadParams(handles, paramsFromFile)
    %% Transfer params from file to the form requested in their UIControls
    % Only params in main GUI included here
    set(handles.currentProtocolName, 'string', paramsFromFile.currentProtocolName);
    setappdata(handles.MonkeyTrainingGUIFig, 'currentProtocolCode', paramsFromFile.currentProtocolCode);

    set(handles.serialPort, 'value', paramsFromFile.serialPort);
    set(handles.delayTime, 'string', num2str(paramsFromFile.delayTime));
    set(handles.pushToOnsetInterval, 'string', num2str(paramsFromFile.pushToOnsetInterval));
    set(handles.choiceWindow, 'string', numstrcat(paramsFromFile.choiceWindow, ','));
    set(handles.waterDelayTimeDev, 'string', num2str(paramsFromFile.waterDelayTimeDev));
    set(handles.waterDelayTimeStd, 'string', num2str(paramsFromFile.waterDelayTimeStd));
    set(handles.rewardTimeCorrect, 'string', num2str(paramsFromFile.rewardTimeCorrect));
    set(handles.ISI_average, 'string', num2str(paramsFromFile.ISI_average));

    set(handles.stdNumList, 'value', 4);
    set(handles.stdNumCustom, 'string', numstrcat(paramsFromFile.stdNumArray, ','));
    set(handles.stdNumCustom, 'Enable', 'on');
    setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', eval(['[' get(handles.stdNumCustom, 'string') ']''']));
    set(handles.stdNumProb, 'string', numstrcat(paramsFromFile.stdNumProb, ','));

    set(handles.soundType, 'SelectedObject', handles.(paramsFromFile.soundType));
    set(handles.soundType, 'UserData', paramsFromFile.soundType);

    set(handles.sweepCountMax, 'string', num2str(paramsFromFile.sweepCountMax));

    set(handles.punishDelayTime, 'string', num2str(paramsFromFile.punishDelayTime));

    set(handles.frequencyStd, 'string', num2str(paramsFromFile.frequencyStd));
    set(handles.intensityStd, 'string', num2str(paramsFromFile.intensityStd));
    set(handles.durationStd, 'string', num2str(paramsFromFile.durationStd));
    set(handles.randomStdFreqFlag, 'value', paramsFromFile.randomStdFreqFlag);

    set(handles.stiPosition, 'SelectedObject', handles.(paramsFromFile.stiPosition));
    set(handles.stiPosition, 'UserData', paramsFromFile.stiPosition);

    set(handles.freqBaseDiffRatio, 'string', num2str(paramsFromFile.freqBaseDiffRatio));
    set(handles.intensityMinDiff, 'string', num2str(paramsFromFile.intensityMinDiff));
    set(handles.durBaseDiffRatio, 'string', num2str(paramsFromFile.durBaseDiffRatio));

    set(handles.freqDiffProb, 'string', numstrcat(paramsFromFile.freqDiffProb, ','));
    set(handles.intensityDiffProb, 'string', numstrcat(paramsFromFile.intensityDiffProb, ','));
    set(handles.durationDiffProb, 'string', numstrcat(paramsFromFile.durationDiffProb, ','));

    set(handles.freqIncOrDec, 'SelectedObject', handles.(paramsFromFile.freqIncOrDec));
    set(handles.freqIncOrDec, 'UserData', paramsFromFile.freqIncOrDec);

    set(handles.intensityIncOrDec, 'SelectedObject', handles.(paramsFromFile.intensityIncOrDec));
    set(handles.intensityIncOrDec, 'UserData', paramsFromFile.intensityIncOrDec);

    set(handles.durationIncOrDec, 'SelectedObject', handles.(paramsFromFile.durationIncOrDec));
    set(handles.durationIncOrDec, 'UserData', paramsFromFile.durationIncOrDec);

    %% Update appdata
    paramsNames = fieldnames(paramsFromFile);
    params = getappdata(handles.MonkeyTrainingGUIFig, 'params');

    for index = 1:size(paramsNames, 1)
        params.(paramsNames{index}) = paramsFromFile.(paramsNames{index});
    end

    setappdata(handles.MonkeyTrainingGUIFig, 'params', params);
    paramsLoad = params;
    setappdata(handles.MonkeyTrainingGUIFig, 'paramsLoad', paramsLoad);

    return;
end
