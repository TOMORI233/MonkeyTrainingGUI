function varargout = PEOddAttentionOscillationSetting(varargin)
% PEOddAttentionOscillationSetting MATLAB code for PEOddAttentionOscillationSetting.fig
%      PEOddAttentionOscillationSetting, by itself, creates a new PEOddAttentionOscillationSetting or raises the existing
%      singleton*.
%
%      H = PEOddAttentionOscillationSetting returns the handle to a new PEOddAttentionOscillationSetting or the handle to
%      the existing singleton*.
%
%      PEOddAttentionOscillationSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEOddAttentionOscillationSetting.M with the given input arguments.
%
%      PEOddAttentionOscillationSetting('Property','Value',...) creates a new PEOddAttentionOscillationSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddAttentionOscillationSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddAttentionOscillationSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddAttentionOscillationSetting

% Last Modified by GUIDE v2.5 30-Nov-2022 17:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddAttentionOscillationSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddAttentionOscillationSetting_OutputFcn, ...
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


% --- Executes just before PEOddAttentionOscillationSetting is made visible.
function PEOddAttentionOscillationSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddAttentionOscillationSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        %% TODO: Initiate your params here
        set(handles.ISI_step, 'string', num2str(paramsLoad.ISI_step));
        set(handles.ISI_range, 'string', numstrcat(paramsLoad.ISI_range));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddAttentionOscillationSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddAttentionOscillationSetting wait for user response (see UIRESUME)
uiwait(handles.AttentionOscillationSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddAttentionOscillationSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.AttentionOscillationSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
%% Load params from appdata
params = getappdata(handles.AttentionOscillationSettingFig, 'params');
%% TODO: Update your params here
% edit
params.ISI_step = str2double(get(handles.ISI_step, 'string'));
params.ISI_range = eval(['[', get(handles.ISI_range, 'string'), ']']);
% ----------------------------------------------------
%% Save params to appdata
setappdata(handles.AttentionOscillationSettingFig, 'params', params);
uiresume(handles.AttentionOscillationSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.AttentionOscillationSettingFig, 'params', []);
uiresume(handles.AttentionOscillationSettingFig);


% --- Executes during object creation, after setting all properties.
function ISI_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ISI_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ISI_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ISI_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close AttentionOscillationSettingFig.
function AttentionOscillationSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to AttentionOscillationSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on AttentionOscillationSettingFig or any of its controls.
function AttentionOscillationSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to AttentionOscillationSettingFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end

