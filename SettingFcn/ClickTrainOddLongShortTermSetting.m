function varargout = ClickTrainOddLongShortTermSetting(varargin)
% ClickTrainOddLongShortTermSetting MATLAB code for ClickTrainOddLongShortTermSetting.fig
%      ClickTrainOddLongShortTermSetting, by itself, creates a new ClickTrainOddLongShortTermSetting or raises the existing
%      singleton*.
%
%      H = ClickTrainOddLongShortTermSetting returns the handle to a new ClickTrainOddLongShortTermSetting or the handle to
%      the existing singleton*.
%
%      ClickTrainOddLongShortTermSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ClickTrainOddLongShortTermSetting.M with the given input arguments.
%
%      ClickTrainOddLongShortTermSetting('Property','Value',...) creates a new ClickTrainOddLongShortTermSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ClickTrainOddLongShortTermSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ClickTrainOddLongShortTermSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ClickTrainOddLongShortTermSetting

% Last Modified by GUIDE v2.5 09-Jun-2022 20:11:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClickTrainOddLongShortTermSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @ClickTrainOddLongShortTermSetting_OutputFcn, ...
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


% --- Executes just before ClickTrainOddLongShortTermSetting is made visible.
function ClickTrainOddLongShortTermSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ClickTrainOddLongShortTermSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
%         set(handles.pairs, 'string', num2str(paramsLoad.pairs));
        set(handles.orders, 'string', num2str(paramsLoad.orders));
        set(handles.orderProb, 'string', num2str(rats(paramsLoad.orderProb, 3)));
        set(handles.standardDeviation, 'string', num2str(paramsLoad.standardDeviation));
        set(handles.ISIVar, 'string', num2str(paramsLoad.ISIVar));
        set(handles.residual, 'string', num2str(paramsLoad.residual));
        set(handles.transTrialNum, 'string', num2str(paramsLoad.transTrialNum));
        

    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for ClickTrainOddLongShortTermSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ClickTrainOddLongShortTermSetting wait for user response (see UIRESUME)
uiwait(handles.ClickTrainOddLSTSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = ClickTrainOddLongShortTermSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.ClickTrainOddLSTSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
%% Load params from appdata
params = getappdata(handles.ClickTrainOddLSTSettingFig, 'params');
%% TODO: Update your params here
% edit

params.pairs = eval(['[' get(handles.pairs, 'string') ']']);
params.orders = eval(['[' get(handles.orders, 'string') ']']);
params.orderProb = eval(['[' get(handles.orderProb, 'string') ']']);
params.standardDeviation = eval(['[' get(handles.standardDeviation, 'string') ']']);
params.ISIVar = eval(['[' get(handles.ISIVar, 'string') ']']);
params.residual = eval(['[' get(handles.residual, 'string') ']']);
params.transTrialNum = eval(['[' get(handles.transTrialNum, 'string') ']']);

%% Save params to appdata
setappdata(handles.ClickTrainOddLSTSettingFig, 'params', params);
uiresume(handles.ClickTrainOddLSTSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.ClickTrainOddLSTSettingFig, 'params', []);
uiresume(handles.ClickTrainOddLSTSettingFig);


% --- Executes during object creation, after setting all properties.
function pairs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pairs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function orders_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close ClickTrainOddLSTSettingFig.
function ClickTrainOddLSTSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ClickTrainOddLSTSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on ClickTrainOddLSTSettingFig or any of its controls.
function ClickTrainOddLSTSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ClickTrainOddLSTSettingFig (see GCBO)
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





function orderProb_Callback(hObject, eventdata, handles)
% hObject    handle to orderProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orderProb as text
%        str2double(get(hObject,'String')) returns contents of orderProb as a double


% --- Executes during object creation, after setting all properties.
function orderProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orderProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function ISIVar_Callback(hObject, eventdata, handles)
% hObject    handle to ISIVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ISIVar as text
%        str2double(get(hObject,'String')) returns contents of ISIVar as a double


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



function residual_Callback(hObject, eventdata, handles)
% hObject    handle to residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of residual as text
%        str2double(get(hObject,'String')) returns contents of residual as a double


% --- Executes during object creation, after setting all properties.
function residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function transTrialNum_Callback(hObject, eventdata, handles)
% hObject    handle to transTrialNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of transTrialNum as text
%        str2double(get(hObject,'String')) returns contents of transTrialNum as a double


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
