function varargout = PEOddS1S2GroupSetting(varargin)
% PEODDS1S2GROUPSETTING MATLAB code for PEOddS1S2GroupSetting.fig
%      PEODDS1S2GROUPSETTING, by itself, creates a new PEODDS1S2GROUPSETTING or raises the existing
%      singleton*.
%
%      H = PEODDS1S2GROUPSETTING returns the handle to a new PEODDS1S2GROUPSETTING or the handle to
%      the existing singleton*.
%
%      PEODDS1S2GROUPSETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEODDS1S2GROUPSETTING.M with the given input arguments.
%
%      PEODDS1S2GROUPSETTING('Property','Value',...) creates a new PEODDS1S2GROUPSETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddS1S2GroupSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddS1S2GroupSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddS1S2GroupSetting

% Last Modified by GUIDE v2.5 09-Jun-2022 20:46:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddS1S2GroupSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddS1S2GroupSetting_OutputFcn, ...
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


% --- Executes just before PEOddS1S2GroupSetting is made visible.
function PEOddS1S2GroupSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddS1S2GroupSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.freq2StdRatio, 'string', num2str(paramsLoad.freq2StdRatio));
        set(handles.IntervalInGroup, 'string', num2str(paramsLoad.IntervalInGroup));
        set(handles.IntervalOutGroup, 'string', num2str(paramsLoad.IntervalOutGroup));
        set(handles.lastStdToDev, 'string', num2str(paramsLoad.lastStdToDev));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddS1S2GroupSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddS1S2GroupSetting wait for user response (see UIRESUME)
uiwait(handles.PEOddS1S2GroupSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddS1S2GroupSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.PEOddS1S2GroupSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params.freq2StdRatio = str2double(get(handles.freq2StdRatio, 'String'));
params.IntervalInGroup = str2double(get(handles.IntervalInGroup, 'String'));
params.IntervalOutGroup = str2double(get(handles.IntervalOutGroup, 'String'));
params.lastStdToDev = str2double(get(handles.lastStdToDev, 'String'));

setappdata(handles.PEOddS1S2GroupSettingFig, 'params', params);

uiresume(handles.PEOddS1S2GroupSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.PEOddS1S2GroupSettingFig, 'params', []);
uiresume(handles.PEOddS1S2GroupSettingFig);


function freqTrialRatio_Callback(hObject, eventdata, handles)
% hObject    handle to freqTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqTrialRatio as text
%        str2double(get(hObject,'String')) returns contents of freqTrialRatio as a double


% --- Executes during object creation, after setting all properties.
function freqTrialRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intensityTrialRatio_Callback(hObject, eventdata, handles)
% hObject    handle to intensityTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intensityTrialRatio as text
%        str2double(get(hObject,'String')) returns contents of intensityTrialRatio as a double


% --- Executes during object creation, after setting all properties.
function intensityTrialRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intensityTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function doubleTrialRatio_Callback(hObject, eventdata, handles)
% hObject    handle to doubleTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of doubleTrialRatio as text
%        str2double(get(hObject,'String')) returns contents of doubleTrialRatio as a double


% --- Executes during object creation, after setting all properties.
function doubleTrialRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to doubleTrialRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close PEOddS1S2GroupSettingFig.
function PEOddS1S2GroupSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PEOddS1S2GroupSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on PEOddS1S2GroupSettingFig or any of its controls.
function PEOddS1S2GroupSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PEOddS1S2GroupSettingFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end



function freq2StdRatio_Callback(hObject, eventdata, handles)
% hObject    handle to freq2StdRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq2StdRatio as text
%        str2double(get(hObject,'String')) returns contents of freq2StdRatio as a double


% --- Executes during object creation, after setting all properties.
function freq2StdRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq2StdRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IntervalInGroup_Callback(hObject, eventdata, handles)
% hObject    handle to IntervalInGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IntervalInGroup as text
%        str2double(get(hObject,'String')) returns contents of IntervalInGroup as a double


% --- Executes during object creation, after setting all properties.
function IntervalInGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IntervalInGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IntervalOutGroup_Callback(hObject, eventdata, handles)
% hObject    handle to IntervalOutGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IntervalOutGroup as text
%        str2double(get(hObject,'String')) returns contents of IntervalOutGroup as a double


% --- Executes during object creation, after setting all properties.
function IntervalOutGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IntervalOutGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lastStdToDev_Callback(hObject, eventdata, handles)
% hObject    handle to lastStdToDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lastStdToDev as text
%        str2double(get(hObject,'String')) returns contents of lastStdToDev as a double


% --- Executes during object creation, after setting all properties.
function lastStdToDev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lastStdToDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
