function varargout = MonkeyTrainingGUI(varargin)
% MONKEYTRAININGGUI MATLAB code for MonkeyTrainingGUI.fig
%      MONKEYTRAININGGUI, by itself, creates a new MONKEYTRAININGGUI or raises the existing
%      singleton*.
%
%      H = MONKEYTRAININGGUI returns the handle to a new MONKEYTRAININGGUI or the handle to
%      the existing singleton*.
%
%      MONKEYTRAININGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONKEYTRAININGGUI.M with the given input arguments.
%
%      MONKEYTRAININGGUI('Property','Value',...) creates a new MONKEYTRAININGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MonkeyTrainingGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MonkeyTrainingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MonkeyTrainingGUI

% Last Modified by GUIDE v2.5 25-May-2022 15:22:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonkeyTrainingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MonkeyTrainingGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MonkeyTrainingGUI is made visible.
function MonkeyTrainingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MonkeyTrainingGUI (see VARARGIN)

addpath(genpath(fileparts(mfilename('fullpath'))));
warning off;
load('protocolList.mat', 'protocolList');
searchResult = protocolList;
selectedProtocolIndex = 1;

setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', (7:10)');
setappdata(handles.MonkeyTrainingGUIFig, 'protocolList', protocolList);
setappdata(handles.MonkeyTrainingGUIFig, 'searchResult', searchResult);
setappdata(handles.MonkeyTrainingGUIFig, 'selectedProtocolIndex', selectedProtocolIndex);
setappdata(handles.MonkeyTrainingGUIFig, 'currentProtocolCode', protocolList(1).protocolCode);

set(handles.listBox, 'string', {protocolList.protocolName});
set(handles.currentProtocolName, 'string', protocolList(1).protocolName);
set(handles.protocolDetail, 'string', protocolList(1).protocolDetail);
set(handles.soundType, 'UserData', 'pureTone');
set(handles.freqIncOrDec, 'UserData', 'freqInc');
set(handles.intensityIncOrDec, 'UserData', 'intensityInc');
set(handles.durationIncOrDec, 'UserData', 'durationInc');
set(handles.stiPosition, 'UserData', 'positionA');
set(handles.activeOrPassive, 'UserData', 'activeBehavior');
set(handles.activeOrPassive, 'SelectedObject', handles.activeBehavior);
set(handles.buttonStop, 'Enable', 'off');

% Choose default command line output for MonkeyTrainingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MonkeyTrainingGUI wait for user response (see UIRESUME)
% uiwait(handles.MonkeyTrainingGUIFig);


% --- Outputs from this function are returned to the command line.
function varargout = MonkeyTrainingGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in serialPort.
function serialPort_Callback(hObject, eventdata, handles)
% hObject    handle to serialPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns serialPort contents as cell array
%        contents{get(hObject,'Value')} returns selected item from serialPort


% --- Executes during object creation, after setting all properties.
function serialPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to serialPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function searchBox_Callback(hObject, eventdata, handles)
% hObject    handle to searchBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of searchBox as text
%        str2double(get(hObject,'String')) returns contents of searchBox as a double
protocolList = getappdata(handles.MonkeyTrainingGUIFig, 'protocolList');
set(handles.listBox, 'Enable', 'on');
set(handles.buttonSetParams, 'Enable', 'on');
keyword = get(handles.searchBox, 'String');
if ~isempty(keyword)
    searchResult = SearchKeywordInProtocolList(keyword, protocolList);
    if isempty(searchResult)
        searchResult = protocolList;
        set(handles.listBox, 'String', 'Not Found', 'Value', 1);
        set(handles.listBox, 'Enable', 'inactive');
        set(handles.buttonSetParams, 'Enable', 'inactive');
    else
        set(handles.listBox, 'String', {searchResult.protocolName}, 'Value', 1);
    end
else
    searchResult = protocolList;
    set(handles.listBox, 'String', {protocolList.protocolName}, 'Value', 1);
end
set(handles.protocolDetail, 'String', searchResult(1).protocolDetail);
setappdata(handles.MonkeyTrainingGUIFig, 'selectedProtocolIndex', 1);
setappdata(handles.MonkeyTrainingGUIFig, 'searchResult', searchResult);


% --- Executes during object creation, after setting all properties.
function searchBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to searchBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listBox.
function listBox_Callback(hObject, eventdata, handles)
% hObject    handle to listBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listBox
clickTime = getappdata(handles.MonkeyTrainingGUIFig, 'clickTime');
searchResult = getappdata(handles.MonkeyTrainingGUIFig, 'searchResult');
lastSelectedIndex = getappdata(handles.MonkeyTrainingGUIFig, 'selectedProtocolIndex');
selectedProtocolIndex = get(hObject, 'Value');
if ~isempty(clickTime) && (now-clickTime)*24*3600<=0.5 && lastSelectedIndex==selectedProtocolIndex
    buttonSetParams_Callback(hObject, eventdata, handles);
end
clickTime = now;
set(handles.protocolDetail, 'String', searchResult(selectedProtocolIndex).protocolDetail);
setappdata(handles.MonkeyTrainingGUIFig, 'clickTime', clickTime);
setappdata(handles.MonkeyTrainingGUIFig, 'selectedProtocolIndex', selectedProtocolIndex);


% --- Executes during object creation, after setting all properties.
function listBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSetParams.
function buttonSetParams_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSetParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
searchResult = getappdata(handles.MonkeyTrainingGUIFig, 'searchResult');
protocolList = getappdata(handles.MonkeyTrainingGUIFig, 'protocolList');
selectedProtocolIndex = getappdata(handles.MonkeyTrainingGUIFig, 'selectedProtocolIndex');

set(handles.currentProtocolName, 'String', searchResult(selectedProtocolIndex).protocolName);
setappdata(handles.MonkeyTrainingGUIFig, 'currentProtocolCode', searchResult(selectedProtocolIndex).protocolCode);

SetProtocolUI(handles, searchResult(selectedProtocolIndex).protocolCode);
ProtocolSetParams(handles, protocolList, searchResult(selectedProtocolIndex).protocolCode);


% --- Executes on button press in buttonStart.
function buttonStart_Callback(hObject, eventdata, handles)
% hObject    handle to buttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
protocolList = getappdata(handles.MonkeyTrainingGUIFig, 'protocolList');
currentProtocolCode = getappdata(handles.MonkeyTrainingGUIFig, 'currentProtocolCode');
callbackFcn = protocolList([protocolList.protocolCode]==currentProtocolCode).serialCallbackFcn;
stimuliFcn = protocolList([protocolList.protocolCode]==currentProtocolCode).stimuliFcn;
GetParams(handles);
params = getappdata(handles.MonkeyTrainingGUIFig, 'params');
[passOrNot, errorMsg] = ValidateParams(params);
if ~passOrNot
    Msgbox(errorMsg, 'Validation Failure');
else
    %% Open serial port
    disp('Opening serial port...');
    device = getappdata(handles.MonkeyTrainingGUIFig, 'device');
    if isempty(device)
        try
            device = serialport(['COM' num2str(get(handles.serialPort, 'value'))], 115200);
            setappdata(handles.MonkeyTrainingGUIFig, 'device', device);
        catch
            Msgbox('Port open FAILED!', 'Error', 'center');
            error('Port open FAILED!');
        end
    end
    %% Run stimuliFcn
    try
        DTO.callbackFcn = callbackFcn;
        DTO.params = params;
        set(device, 'UserData', DTO);
        stimuliFcn(device);
        set(handles.buttonStart, 'Enable', 'off');
        set(handles.buttonStop, 'Enable', 'on');
        Msgbox('START!', 'Info', 'center');
    catch exception
        disp(exception.message);
        Msgbox({'Possible causes:', ...
                '- Params for this protocol MISSING! Please SET PARAMS again', ...
                ' ', ...
                '- *StiFcn.m or *SerialFcn.m of this protocol MISSING', ...
                ' ', ...
                '- Serialport connection FAILED', ...
                ' ',...
                '- TDT device NOT CONNECTED'}, 'Error');
    end
end

% --- Executes on button press in buttonStop.
function buttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to buttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    device = getappdata(handles.MonkeyTrainingGUIFig, 'device');
    configureCallback(device, 'off');
    flush(device);
    delete(timerfind);
    delete(instrfindall);
    DTO = get(device, 'UserData');
    obj = DTO.obj;
    obj.idle;
    set(handles.buttonStart, 'Enable', 'on');
    set(handles.buttonStop, 'Enable', 'off');
    Msgbox('STOP!', 'Info', 'center');
catch exception
    disp(exception.message);
end



% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params = GetParams(handles);
try
    uisave('params', [datestr(now, 'yyyymmdd'), '_params']);
catch exception
    disp(exception.message);
end


% --- Executes on button press in buttonLoad.
function buttonLoad_Callback(hObject, eventdata, handles)
% hObject    handle to buttonLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, path] = uigetfile('.mat', 'Load your params');
try
    load([path fileName], 'params');
    LoadParams(handles, params);
    Msgbox('Params loading SUCCESS!', 'Info', 'center');
catch exception
    disp(exception.message);
    Msgbox('Params loading FAILED!', 'Info', 'center');
end


% --- Executes on button press in randomStdFreqFlag.
function randomStdFreqFlag_Callback(hObject, eventdata, handles)
% hObject    handle to randomStdFreqFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of randomStdFreqFlag


% --- Executes on selection change in stdNumList.
function stdNumList_Callback(hObject, eventdata, handles)
% hObject    handle to stdNumList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stdNumList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stdNumList
if get(hObject, 'Value') == 4
    set(handles.stdNumCustom, 'Enable', 'on');
    stdNumCustom = eval(['[' get(handles.stdNumCustom, 'string') ']''']);
    set(handles.stdNumProb, 'string', numstrcat(ones(length(stdNumCustom), 1)/length(stdNumCustom), ','));
else
    set(handles.stdNumCustom, 'Enable', 'off');
    switch get(hObject, 'Value')
        case 1
            setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', (7:10)');
            set(handles.stdNumProb, 'string', numstrcat(ones(4,1)/4, ','));
        case 2
            setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', (1:9)');
            set(handles.stdNumProb, 'string', numstrcat(ones(9,1)/9, ','));
        case 3
            setappdata(handles.MonkeyTrainingGUIFig, 'stdNumArray', (3:6)');
            set(handles.stdNumProb, 'string', numstrcat(ones(4,1)/4, ','));
    end
end



% --- Executes during object creation, after setting all properties.
function stdNumList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdNumList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdNumCustom_Callback(hObject, eventdata, handles)
% hObject    handle to stdNumCustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdNumCustom as text
%        str2double(get(hObject,'String')) returns contents of stdNumCustom as a double
stdNumCustom = eval(['[' get(handles.stdNumCustom, 'string') ']''']);
set(handles.stdNumProb, 'string', numstrcat(ones(length(stdNumCustom), 1)/length(stdNumCustom), ','));



% --- Executes during object creation, after setting all properties.
function stdNumCustom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdNumCustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delayTime_Callback(hObject, eventdata, handles)
% hObject    handle to delayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delayTime as text
%        str2double(get(hObject,'String')) returns contents of delayTime as a double


% --- Executes during object creation, after setting all properties.
function delayTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushToOnsetInterval_Callback(hObject, eventdata, handles)
% hObject    handle to pushToOnsetInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pushToOnsetInterval as text
%        str2double(get(hObject,'String')) returns contents of pushToOnsetInterval as a double


% --- Executes during object creation, after setting all properties.
function pushToOnsetInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushToOnsetInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function choiceWindow_Callback(hObject, eventdata, handles)
% hObject    handle to choiceWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of choiceWindow as text
%        str2double(get(hObject,'String')) returns contents of choiceWindow as a double


% --- Executes during object creation, after setting all properties.
function choiceWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choiceWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function waterDelayTimeDev_Callback(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waterDelayTimeDev as text
%        str2double(get(hObject,'String')) returns contents of waterDelayTimeDev as a double


% --- Executes during object creation, after setting all properties.
function waterDelayTimeDev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function waterDelayTimeStdText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeStdText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rewardTimeCorrect_Callback(hObject, eventdata, handles)
% hObject    handle to rewardTimeCorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rewardTimeCorrect as text
%        str2double(get(hObject,'String')) returns contents of rewardTimeCorrect as a double


% --- Executes during object creation, after setting all properties.
function rewardTimeCorrect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rewardTimeCorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rewardTimeWrong_Callback(hObject, eventdata, handles)
% hObject    handle to rewardTimeWrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rewardTimeWrong as text
%        str2double(get(hObject,'String')) returns contents of rewardTimeWrong as a double


% --- Executes during object creation, after setting all properties.
function rewardTimeWrong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rewardTimeWrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ISI_average_Callback(hObject, eventdata, handles)
% hObject    handle to ISI_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ISI_average as text
%        str2double(get(hObject,'String')) returns contents of ISI_average as a double


% --- Executes during object creation, after setting all properties.
function ISI_average_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ISI_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqBaseDiffRatio_Callback(hObject, eventdata, handles)
% hObject    handle to freqBaseDiffRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqBaseDiffRatio as text
%        str2double(get(hObject,'String')) returns contents of freqBaseDiffRatio as a double


% --- Executes during object creation, after setting all properties.
function freqBaseDiffRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqBaseDiffRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intensityMinDiff_Callback(hObject, eventdata, handles)
% hObject    handle to intensityMinDiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intensityMinDiff as text
%        str2double(get(hObject,'String')) returns contents of intensityMinDiff as a double


% --- Executes during object creation, after setting all properties.
function intensityMinDiff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intensityMinDiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function durBaseDiffRatio_Callback(hObject, eventdata, handles)
% hObject    handle to durBaseDiffRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of durBaseDiffRatio as text
%        str2double(get(hObject,'String')) returns contents of durBaseDiffRatio as a double


% --- Executes during object creation, after setting all properties.
function durBaseDiffRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to durBaseDiffRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqDiffProb_Callback(hObject, eventdata, handles)
% hObject    handle to freqDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqDiffProb as text
%        str2double(get(hObject,'String')) returns contents of freqDiffProb as a double


% --- Executes during object creation, after setting all properties.
function freqDiffProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intensityDiffProb_Callback(hObject, eventdata, handles)
% hObject    handle to intensityDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intensityDiffProb as text
%        str2double(get(hObject,'String')) returns contents of intensityDiffProb as a double


% --- Executes during object creation, after setting all properties.
function intensityDiffProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intensityDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function durationDiffProb_Callback(hObject, eventdata, handles)
% hObject    handle to durationDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of durationDiffProb as text
%        str2double(get(hObject,'String')) returns contents of durationDiffProb as a double


% --- Executes during object creation, after setting all properties.
function durationDiffProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to durationDiffProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequencyStd_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequencyStd as text
%        str2double(get(hObject,'String')) returns contents of frequencyStd as a double


% --- Executes during object creation, after setting all properties.
function frequencyStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intensityStd_Callback(hObject, eventdata, handles)
% hObject    handle to intensityStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intensityStd as text
%        str2double(get(hObject,'String')) returns contents of intensityStd as a double


% --- Executes during object creation, after setting all properties.
function intensityStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intensityStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function durationStd_Callback(hObject, eventdata, handles)
% hObject    handle to durationStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of durationStd as text
%        str2double(get(hObject,'String')) returns contents of durationStd as a double


% --- Executes during object creation, after setting all properties.
function durationStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to durationStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in soundType.
function soundType_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in soundType 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.soundType, 'UserData', get(hObject, 'tag'));


% --- Executes when selected object is changed in freqIncOrDec.
function freqIncOrDec_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in freqIncOrDec 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.freqIncOrDec, 'UserData', get(hObject, 'tag'));


% --- Executes when selected object is changed in intensityIncOrDec.
function intensityIncOrDec_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in intensityIncOrDec 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.intensityIncOrDec, 'UserData', get(hObject, 'tag'));


% --- Executes when selected object is changed in durationIncOrDec.
function durationIncOrDec_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in durationIncOrDec 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.durationIncOrDec, 'UserData', get(hObject, 'tag'));


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over searchBox.
function searchBox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to searchBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'Enable'), 'inactive')
    set(hObject, 'ForegroundColor', [0,0,0]);
    set(hObject, 'Enable', 'on');
    set(hObject, 'String', '');
end
uicontrol(hObject);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over delayTimeText.
function delayTimeText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to delayTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Msgbox('From the last stimuli onset of the previous trial to the next trial onset', 'Definition');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over push2onsetText.
function push2onsetText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to push2onsetText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Msgbox('From button pressed down to trial onset', 'Definition');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over waterDelayTimeDevText.
function waterDelayTimeDevText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeDevText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Msgbox('From button pressed down for deviant stimuli to water onset', 'Definition');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over waterDelayTimeStdText.
function waterDelayTimeStdText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeStdText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Msgbox('From the last standard stimuli onset to water onset', 'Definition');


% --- Executes on mouse press over figure background.
function MonkeyTrainingGUIFig_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MonkeyTrainingGUIFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function MonkeyTrainingGUIFig_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MonkeyTrainingGUIFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.searchBox, 'String'))
    set(handles.searchBox, 'ForegroundColor', [105/255,105/255,105/255]);
    set(handles.searchBox, 'Enable', 'inactive');
    set(handles.searchBox, 'String', 'Please Input Protocol Name');
end


% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noise



function waterDelayTimeStd_Callback(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waterDelayTimeStd as text
%        str2double(get(hObject,'String')) returns contents of waterDelayTimeStd as a double


% --- Executes during object creation, after setting all properties.
function waterDelayTimeStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterDelayTimeStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function protocolDetail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to protocolDetail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function sweepCountMax_Callback(hObject, eventdata, handles)
% hObject    handle to sweepCountMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepCountMax as text
%        str2double(get(hObject,'String')) returns contents of sweepCountMax as a double


% --- Executes during object creation, after setting all properties.
function sweepCountMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepCountMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in stiPosition.
function stiPosition_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in stiPosition 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.stiPosition, 'UserData', get(hObject, 'tag'));


function punishDelayTime_Callback(hObject, eventdata, handles)
% hObject    handle to punishDelayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of punishDelayTime as text
%        str2double(get(hObject,'String')) returns contents of punishDelayTime as a double


% --- Executes during object creation, after setting all properties.
function punishDelayTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to punishDelayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdNumProb_Callback(hObject, eventdata, handles)
% hObject    handle to stdNumProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdNumProb as text
%        str2double(get(hObject,'String')) returns contents of stdNumProb as a double


% --- Executes during object creation, after setting all properties.
function stdNumProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdNumProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listBox.
function listBox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in activeOrPassive.
function activeOrPassive_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in activeOrPassive 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.activeOrPassive, 'UserData', get(hObject, 'tag'));


% --- Executes on button press in fixedDevFlag.
function fixedDevFlag_Callback(hObject, eventdata, handles)
% hObject    handle to fixedDevFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fixedDevFlag


% --- Executes on button press in offsetChoiceWinFlag.
function offsetChoiceWinFlag_Callback(hObject, eventdata, handles)
% hObject    handle to offsetChoiceWinFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of offsetChoiceWinFlag
