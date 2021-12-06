function params = ProtocolSetParams(handles, protocolList, selectedProtocolCode)
    params = getappdata(handles.MonkeyTrainingGUIFig, 'params');
    paramsLoad = getappdata(handles.MonkeyTrainingGUIFig, 'paramsLoad');

    try
        settingFcn = protocolList([protocolList.protocolCode] == selectedProtocolCode).settingFcn;
        
        if ~isempty(settingFcn)
            paramsFromProtocol = settingFcn(paramsLoad);
        end

        if isempty(paramsFromProtocol)
            Msgbox({'Setting CANCELED or setting file MISSING!', ...
                    ' ', ...
                    'Check whether it is intentially left blank.'}, 'Warning');
        else
            paramsNames = fieldnames(paramsFromProtocol);

            for index = 1:size(paramsNames, 1)
                params.(paramsNames{index}) = paramsFromProtocol.(paramsNames{index});
            end

            setappdata(handles.MonkeyTrainingGUIFig, 'params', params);
            setappdata(handles.MonkeyTrainingGUIFig, 'paramsLoad', params);
            Msgbox('Settings DONE!', 'Info', 'center');
        end

    catch exception
        Msgbox('An unexpected error ocurred!', 'Error', 'center');
        disp(exception.cause);
    end

    return;
end
