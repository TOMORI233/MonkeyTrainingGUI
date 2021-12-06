function params = GetParams(handles)
    %% Update params of UIControls to AppData of the main figure, MonkeyTrainingGUIFig here
    paramsGet.currentProtocolName = get(handles.currentProtocolName, 'string');
    paramsGet.currentProtocolCode = getappdata(handles.MonkeyTrainingGUIFig, 'currentProtocolCode');

    paramsGet.serialPort = get(handles.serialPort, 'value');
    paramsGet.delayTime = str2double(get(handles.delayTime, 'string'));
    paramsGet.pushToOnsetInterval = str2double(get(handles.pushToOnsetInterval, 'string'));
    paramsGet.choiceWindow = str2double(split(get(handles.choiceWindow, 'string'), ','));
    paramsGet.waterDelayTimeDev = str2double(get(handles.waterDelayTimeDev, 'string'));
    paramsGet.waterDelayTimeStd = str2double(get(handles.waterDelayTimeStd, 'string'));
    paramsGet.rewardTimeCorrect = str2double(get(handles.rewardTimeCorrect, 'string'));
    paramsGet.ISI_average = str2double(get(handles.ISI_average, 'string'));

    if get(handles.stdNumList, 'value') == 4
        setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', eval(['[' get(handles.stdNumCustom, 'string') ']''']));
    end

    paramsGet.stdNumArray = getappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray');

    paramsGet.stdNumProb = eval(['[' get(handles.stdNumProb, 'string') ']''']);

    paramsGet.soundType = get(handles.soundType, 'UserData');
    paramsGet.sweepCountMax = str2double(get(handles.sweepCountMax, 'string'));
    paramsGet.punishDelayTime = str2double(get(handles.punishDelayTime, 'string'));
    paramsGet.frequencyStd = str2double(get(handles.frequencyStd, 'string'));
    paramsGet.intensityStd = str2double(get(handles.intensityStd, 'string'));
    paramsGet.durationStd = str2double(get(handles.durationStd, 'string'));
    paramsGet.randomStdFreqFlag = get(handles.randomStdFreqFlag, 'value');
    paramsGet.stiPosition = get(handles.stiPosition, 'UserData');
    paramsGet.freqBaseDiffRatio = str2double(get(handles.freqBaseDiffRatio, 'string'));
    paramsGet.intensityMinDiff = str2double(get(handles.intensityMinDiff, 'string'));
    paramsGet.durBaseDiffRatio = str2double(get(handles.durBaseDiffRatio, 'string'));
    paramsGet.freqDiffProb = eval(['[' get(handles.freqDiffProb, 'string') ']''']);
    paramsGet.intensityDiffProb = eval(['[' get(handles.intensityDiffProb, 'string') ']''']);
    paramsGet.durationDiffProb = eval(['[' get(handles.durationDiffProb, 'string') ']''']);
    paramsGet.freqIncOrDec = get(handles.freqIncOrDec, 'UserData');
    paramsGet.intensityIncOrDec = get(handles.intensityIncOrDec, 'UserData');
    paramsGet.durationIncOrDec = get(handles.durationIncOrDec, 'UserData');

    %% Save UI params to appdata
    paramsNames = fieldnames(paramsGet);
    params = getappdata(handles.MonkeyTrainingGUIFig, 'params');

    for index = 1:size(paramsNames, 1)
        params.(paramsNames{index}) = paramsGet.(paramsNames{index});
    end

    setappdata(handles.MonkeyTrainingGUIFig, 'params', params);

    return;
end
