function varargout = DemoSetting(varargin)
% DemoSetting MATLAB code for DemoSetting.fig
%      DemoSetting, by itself, creates a new DemoSetting or raises the existing
%      singleton*.
%
%      H = DemoSetting returns the handle to a new DemoSetting or the handle to
%      the existing singleton*.
%
%      DemoSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DemoSetting.M with the given input arguments.
%
%      DemoSetting('Property','Value',...) creates a new DemoSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DemoSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DemoSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DemoSetting

% Last Modified by GUIDE v2.5 06-Dec-2021 15:30:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DemoSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @DemoSetting_OutputFcn, ...
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


% --- Executes just before DemoSetting is made visible.
function DemoSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DemoSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
        set(handles.var1, 'string', num2str(paramsLoad.var1));
        set(handles.var2, 'string', num2str(paramsLoad.var2));
        set(handles.var3, 'string', num2str(paramsLoad.(paramsLoad.varName)));
        set(handles.varName, 'string', paramsLoad.varName);
        set(handles.fixedDevIntensityFlag, 'value', paramsLoad.fixedDevIntensityFlag);
        set(handles.menuParam, 'value', find(strcmp(get(handles.menuParam, 'string'), paramsLoad.menuParam)));
        set(handles.radioParam, 'SelectedObject', handles.(paramsLoad.radioParam));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for DemoSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DemoSetting wait for user response (see UIRESUME)
uiwait(handles.DemoSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = DemoSetting_OutputFcn(hObject, eventdata, handles) 
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
params.var1 = str2double(get(handles.var1, 'string'));
params.var2 = str2double(get(handles.var2, 'string'));
% varName + edit
params.varName = get(handles.varName, "string");
params.(params.varName) = str2double(get(handles.var3, 'string'));
% checkbox
params.fixedDevIntensityFlag = logical(get(handles.fixedDevIntensityFlag, 'value'));
% listbox
contents = cellstr(get(handles.menuParam, 'string'));
selectedItem = contents{get(handles.menuParam, 'value')};
params.menuParam = selectedItem;
% radio button group
selectedRadio = get(handles.radioParam, 'SelectedObject');
params.radioParam = get(selectedRadio, 'tag');
% --------- For Test Only ----------------------------
params.freqTrialRatio = params.var1;
params.intensityTrialRatio = params.var2;
params.doubleTrialRatio = params.(params.varName);
% ----------------------------------------------------
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
function var1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function var2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var2 (see GCBO)
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
function radioParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radioParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
