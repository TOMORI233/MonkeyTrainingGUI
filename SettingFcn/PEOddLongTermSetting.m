function varargout = PEOddLongTermSetting(varargin)
% PEOddLongTermSetting MATLAB code for PEOddLongTermSetting.fig
%      PEOddLongTermSetting, by itself, creates a new PEOddLongTermSetting or raises the existing
%      singleton*.
%
%      H = PEOddLongTermSetting returns the handle to a new PEOddLongTermSetting or the handle to
%      the existing singleton*.
%
%      PEOddLongTermSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEOddLongTermSetting.M with the given input arguments.
%
%      PEOddLongTermSetting('Property','Value',...) creates a new PEOddLongTermSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddLongTermSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddLongTermSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddLongTermSetting

% Last Modified by GUIDE v2.5 21-May-2022 10:08:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddLongTermSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddLongTermSetting_OutputFcn, ...
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


% --- Executes just before PEOddLongTermSetting is made visible.
function PEOddLongTermSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddLongTermSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
        set(handles.transTrialNum, 'string', num2str(paramsLoad.transTrialNum));
        set(handles.standardDeviation, 'string', num2str(paramsLoad.standardDeviation));
        set(handles.lowHighLimit, 'string', num2str(paramsLoad.lowHighLimit));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddLongTermSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddLongTermSetting wait for user response (see UIRESUME)
uiwait(handles.PEOddLongTermSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddLongTermSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.PEOddLongTermSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
%% Load params from appdata
params = getappdata(handles.PEOddLongTermSettingFig, 'params');
%% TODO: Update your params here
% edit

params.transTrialNum = eval(['[' get(handles.transTrialNum, 'string') ']']);
params.standardDeviation = eval(['[' get(handles.standardDeviation, 'string') ']']);
params.lowHighLimit = eval(['[' get(handles.lowHighLimit, 'string') ']']);
%% Save params to appdata
setappdata(handles.PEOddLongTermSettingFig, 'params', params);
uiresume(handles.PEOddLongTermSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.PEOddLongTermSettingFig, 'params', []);
uiresume(handles.PEOddLongTermSettingFig);


% --- Executes during object creation, after setting all properties.
function transTrialNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transTrialNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function standardDeviation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to standardDeviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close PEOddLongTermSettingFig.
function PEOddLongTermSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PEOddLongTermSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on PEOddLongTermSettingFig or any of its controls.
function PEOddLongTermSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PEOddLongTermSettingFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end


% --- Executes during object creation, after setting all properties.
function var3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function menuParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function radioParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radioParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function lowHighLimit_Callback(hObject, eventdata, handles)
% hObject    handle to lowHighLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowHighLimit as text
%        str2double(get(hObject,'String')) returns contents of lowHighLimit as a double


% --- Executes during object creation, after setting all properties.
function lowHighLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowHighLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
