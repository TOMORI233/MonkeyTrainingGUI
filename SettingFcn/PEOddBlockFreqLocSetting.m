function varargout = PEOddBlockFreqLocSetting(varargin)
% PEODDBLOCKFREQLOCSETTING MATLAB code for PEOddBlockFreqLocSetting.fig
%      PEODDBLOCKFREQLOCSETTING, by itself, creates a new PEODDBLOCKFREQLOCSETTING or raises the existing
%      singleton*.
%
%      H = PEODDBLOCKFREQLOCSETTING returns the handle to a new PEODDBLOCKFREQLOCSETTING or the handle to
%      the existing singleton*.
%
%      PEODDBLOCKFREQLOCSETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEODDBLOCKFREQLOCSETTING.M with the given input arguments.
%
%      PEODDBLOCKFREQLOCSETTING('Property','Value',...) creates a new PEODDBLOCKFREQLOCSETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddBlockFreqLocSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddBlockFreqLocSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddBlockFreqLocSetting

% Last Modified by GUIDE v2.5 25-Aug-2022 10:42:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddBlockFreqLocSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddBlockFreqLocSetting_OutputFcn, ...
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


% --- Executes just before PEOddBlockFreqLocSetting is made visible.
function PEOddBlockFreqLocSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddBlockFreqLocSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.freqTrialN, 'string', num2str(paramsLoad.freqTrialN));
        set(handles.locTrialN, 'string', num2str(paramsLoad.locTrialN));
        set(handles.randTrialN, 'string', num2str(paramsLoad.randTrialN));
        set(handles.locationNum, 'string', num2str(paramsLoad.locationNum));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddBlockFreqLocSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddBlockFreqLocSetting wait for user response (see UIRESUME)
uiwait(handles.PEOddBlockFreqLocSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddBlockFreqLocSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.PEOddBlockFreqLocSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params.freqTrialN = str2double(get(handles.freqTrialN, 'String'));
params.locTrialN = str2double(get(handles.locTrialN, 'String'));
params.randTrialN = str2double(get(handles.randTrialN, 'String'));
params.locationNum = str2double(get(handles.locationNum, 'String'));
setappdata(handles.PEOddBlockFreqLocSettingFig, 'params', params);

uiresume(handles.PEOddBlockFreqLocSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.PEOddBlockFreqLocSettingFig, 'params', []);
uiresume(handles.PEOddBlockFreqLocSettingFig);


function freqTrialN_Callback(hObject, eventdata, handles)
% hObject    handle to freqTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqTrialN as text
%        str2double(get(hObject,'String')) returns contents of freqTrialN as a double


% --- Executes during object creation, after setting all properties.
function freqTrialN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function locTrialN_Callback(hObject, eventdata, handles)
% hObject    handle to locTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of locTrialN as text
%        str2double(get(hObject,'String')) returns contents of locTrialN as a double


% --- Executes during object creation, after setting all properties.
function locTrialN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to locTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function randTrialN_Callback(hObject, eventdata, handles)
% hObject    handle to randTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of randTrialN as text
%        str2double(get(hObject,'String')) returns contents of randTrialN as a double


% --- Executes during object creation, after setting all properties.
function randTrialN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to randTrialN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close PEOddBlockFreqLocSettingFig.
function PEOddBlockFreqLocSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PEOddBlockFreqLocSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on PEOddBlockFreqLocSettingFig or any of its controls.
function PEOddBlockFreqLocSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PEOddBlockFreqLocSettingFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end



function locationNum_Callback(hObject, eventdata, handles)
% hObject    handle to locationNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of locationNum as text
%        str2double(get(hObject,'String')) returns contents of locationNum as a double


% --- Executes during object creation, after setting all properties.
function locationNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to locationNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
