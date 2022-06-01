function varargout = WorkingMemorySetting(varargin)
% WORKINGMEMORYSETTING MATLAB code for WorkingMemorySetting.fig
%      WORKINGMEMORYSETTING, by itself, creates a new WORKINGMEMORYSETTING or raises the existing
%      singleton*.
%
%      H = WORKINGMEMORYSETTING returns the handle to a new WORKINGMEMORYSETTING or the handle to
%      the existing singleton*.
%
%      WORKINGMEMORYSETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORKINGMEMORYSETTING.M with the given input arguments.
%
%      WORKINGMEMORYSETTING('Property','Value',...) creates a new WORKINGMEMORYSETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WorkingMemorySetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WorkingMemorySetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WorkingMemorySetting

% Last Modified by GUIDE v2.5 01-Jun-2022 09:49:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WorkingMemorySetting_OpeningFcn, ...
                   'gui_OutputFcn',  @WorkingMemorySetting_OutputFcn, ...
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


% --- Executes just before WorkingMemorySetting is made visible.
function WorkingMemorySetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WorkingMemorySetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.freqTrialRatio, 'string', num2str(paramsLoad.freqTrialRatio));
        set(handles.intensityTrialRatio, 'string', num2str(paramsLoad.intensityTrialRatio));
        set(handles.doubleTrialRatio, 'string', num2str(paramsLoad.doubleTrialRatio));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for WorkingMemorySetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WorkingMemorySetting wait for user response (see UIRESUME)
uiwait(handles.CueIntegrationSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = WorkingMemorySetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.CueIntegrationSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params.freqTrialRatio = str2double(get(handles.freqTrialRatio, 'String'));
params.intensityTrialRatio = str2double(get(handles.intensityTrialRatio, 'String'));
params.doubleTrialRatio = str2double(get(handles.doubleTrialRatio, 'String'));

setappdata(handles.CueIntegrationSettingFig, 'params', params);

uiresume(handles.CueIntegrationSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.CueIntegrationSettingFig, 'params', []);
uiresume(handles.CueIntegrationSettingFig);


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


% --- Executes when user attempts to close CueIntegrationSettingFig.
function CueIntegrationSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to CueIntegrationSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on CueIntegrationSettingFig or any of its controls.
function CueIntegrationSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to CueIntegrationSettingFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end
