function varargout = BindOddFreqLocSetting(varargin)
% BindOddFreqLocSetting MATLAB code for BindOddFreqLocSetting.fig
%      BindOddFreqLocSetting, by itself, creates a new BindOddFreqLocSetting or raises the existing
%      singleton*.
%
%      H = BindOddFreqLocSetting returns the handle to a new BindOddFreqLocSetting or the handle to
%      the existing singleton*.
%
%      BindOddFreqLocSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BindOddFreqLocSetting.M with the given input arguments.
%
%      BindOddFreqLocSetting('Property','Value',...) creates a new BindOddFreqLocSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BindOddFreqLocSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BindOddFreqLocSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BindOddFreqLocSetting

% Last Modified by GUIDE v2.5 30-May-2022 10:23:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BindOddFreqLocSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @BindOddFreqLocSetting_OutputFcn, ...
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


% --- Executes just before BindOddFreqLocSetting is made visible.
function BindOddFreqLocSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BindOddFreqLocSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
        set(handles.seqType, 'string', num2str(paramsLoad.seqType));
        set(handles.typeProb, 'string', num2str(paramsLoad.typeProb));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for BindOddFreqLocSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BindOddFreqLocSetting wait for user response (see UIRESUME)
uiwait(handles.ClickTrainOddSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = BindOddFreqLocSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.ClickTrainOddSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
%% Load params from appdata
params = getappdata(handles.ClickTrainOddSettingFig, 'params');
%% TODO: Update your params here
% edit

params.seqType = eval(['[' get(handles.seqType, 'string') ']']);
params.typeProb = eval(['[' get(handles.typeProb, 'string') ']']);

%% Save params to appdata
setappdata(handles.ClickTrainOddSettingFig, 'params', params);
uiresume(handles.ClickTrainOddSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.ClickTrainOddSettingFig, 'params', []);
uiresume(handles.ClickTrainOddSettingFig);


% --- Executes during object creation, after setting all properties.
function seqType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seqType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function typeProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to typeProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close ClickTrainOddSettingFig.
function ClickTrainOddSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ClickTrainOddSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on ClickTrainOddSettingFig or any of its controls.
function ClickTrainOddSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ClickTrainOddSettingFig (see GCBO)
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
