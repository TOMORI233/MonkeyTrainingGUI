function varargout = WhenOddTimeNumActiveCTSetting(varargin)
% WhenOddTimeNumActiveCTSetting MATLAB code for WhenOddTimeNumActiveCTSetting.fig
%      WhenOddTimeNumActiveCTSetting, by itself, creates a new WhenOddTimeNumActiveCTSetting or raises the existing
%      singleton*.
%
%      H = WhenOddTimeNumActiveCTSetting returns the handle to a new WhenOddTimeNumActiveCTSetting or the handle to
%      the existing singleton*.
%
%      WhenOddTimeNumActiveCTSetting('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WhenOddTimeNumActiveCTSetting.M with the given input arguments.
%
%      WhenOddTimeNumActiveCTSetting('Property','Value',...) creates a new WhenOddTimeNumActiveCTSetting or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WhenOddTimeNumActiveCTSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WhenOddTimeNumActiveCTSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WhenOddTimeNumActiveCTSetting

% Last Modified by GUIDE v2.5 06-Dec-2021 11:49:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WhenOddTimeNumActiveCTSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @WhenOddTimeNumActiveCTSetting_OutputFcn, ...
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


% --- Executes just before WhenOddTimeNumActiveCTSetting is made visible.
function WhenOddTimeNumActiveCTSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WhenOddTimeNumActiveCTSetting (see VARARGIN)

params.cuetype = 'frequency';
setappdata(handles.WhenOddTimeNumActiveCTFig,'params',params);

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.totaltime, 'string', num2str(paramsLoad.totaltime));
        set(handles.totalnum, 'string', num2str(paramsLoad.totalnum));
        set(handles.cuetype, 'SelectedObject', handles.(paramsLoad.cuetype));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for WhenOddTimeNumActiveCTSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WhenOddTimeNumActiveCTSetting wait for user response (see UIRESUME)
uiwait(handles.WhenOddTimeNumActiveCTFig);


% --- Outputs from this function are returned to the command line.
function varargout = WhenOddTimeNumActiveCTSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.WhenOddTimeNumActiveCTFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params = getappdata(handles.WhenOddTimeNumActiveCTFig, 'params');

params.totaltime = str2double(get(handles.totaltime, 'String'));
params.totalnum = str2double(get(handles.totalnum, 'String'));
% ----------------------------------------------------
setappdata(handles.WhenOddTimeNumActiveCTFig, 'params', params);
uiresume(handles.WhenOddTimeNumActiveCTFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.WhenOddTimeNumActiveCTFig, 'params', []);
uiresume(handles.WhenOddTimeNumActiveCTFig);


% --- Executes during object creation, after setting all properties.
function totaltime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totaltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function totalnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close WhenOddTimeNumActiveCTFig.
function WhenOddTimeNumActiveCTFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to WhenOddTimeNumActiveCTFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on WhenOddTimeNumActiveCTFig or any of its controls.
function WhenOddTimeNumActiveCTFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to WhenOddTimeNumActiveCTFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end


% --- Executes when selected object is changed in cuetype.
function cuetype_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in cuetype 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params = getappdata(handles.WhenOddTimeNumActiveCTFig, 'params');
params.cuetype = get(hObject, 'tag');
setappdata(handles.WhenOddTimeNumActiveCTFig, 'params', params);


% --- Executes during object creation, after setting all properties.
function cuetype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cuetype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
