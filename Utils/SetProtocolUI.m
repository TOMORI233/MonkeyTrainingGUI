function SetProtocolUI(handles, protocolCode)

    switch protocolCode
        case "104"
            set(handles.intensityIncOrDec, 'SelectedObject', handles.intensityInc);
            set(handles.intensityIncOrDec, 'UserData', 'intensityInc');
        %% TODO: other protocol
    end

end
