function varargout = PEOddWhatWhenSetting(varargin)
% PEOddWhatWhenSetting MATLAB code for PEOddWhatWhenSetting.fig
%      PEOddWhatWhenSetting, by itself, creates a new PEOddWhatWhenSetting or raises the existing
%      singleton*.
%
%      H = PEOddWhatWhenSetting returns the handle to a new PEOddWhatWhenSetting or the handle to
%      the existing singleton*.
%
%      PEOddWhatWhenSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEOddWhatWhenSetting.M with the given input arguments.
%
%      PEOddWhatWhenSetting('Property','Value',...) creates a new PEOddWhatWhenSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddWhatWhenSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddWhatWhenSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddWhatWhenSetting

% Last Modified by GUIDE v2.5 07-Jun-2022 22:10:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddWhatWhenSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddWhatWhenSetting_OutputFcn, ...
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


% --- Executes just before PEOddWhatWhenSetting is made visible.
function PEOddWhatWhenSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddWhatWhenSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
        set(handles.freqVar, 'string', num2str(paramsLoad.freqVar));
        set(handles.ISIVar, 'string', num2str(paramsLoad.ISIVar));
        set(handles.standardDeviation, 'string', num2str(paramsLoad.standardDeviation));
        set(handles.type, 'SelectedObject', handles.(paramsLoad.type));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddWhatWhenSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddWhatWhenSetting wait for user response (see UIRESUME)
uiwait(handles.DemoSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddWhatWhenSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.DemoSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
%% Load params from appdata
params = getappdata(handles.DemoSettingFig, 'params');
%% TODO: Update your params here
% edit
params.freqVar = eval(['[' get(handles.freqVar, 'string') ']']);
params.ISIVar = eval(['[' get(handles.ISIVar, 'string') ']']);
params.standardDeviation = eval(['[' get(handles.standardDeviation, 'string') ']']);
% radio button group
selectedRadio = get(handles.type, 'SelectedObject');
params.type = get(selectedRadio, 'tag');

%% Save params to appdata
setappdata(handles.DemoSettingFig, 'params', params);
uiresume(handles.DemoSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.DemoSettingFig, 'params', []);
uiresume(handles.DemoSettingFig);


% --- Executes during object creation, after setting all properties.
function freqVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ISIVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ISIVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close DemoSettingFig.
function DemoSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to DemoSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on DemoSettingFig or any of its controls.
function DemoSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to DemoSettingFig (see GCBO)
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
function type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function standardDeviation_Callback(hObject, eventdata, handles)
% hObject    handle to standardDeviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of standardDeviation as text
%        str2double(get(hObject,'String')) returns contents of standardDeviation as a double


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
