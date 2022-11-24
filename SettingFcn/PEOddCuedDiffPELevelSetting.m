function varargout = PEOddCuedDiffPELevelSetting(varargin)
% PEODDCUEDDIFFPELEVELSETTING MATLAB code for PEOddCuedDiffPELevelSetting.fig
%      PEODDCUEDDIFFPELEVELSETTING, by itself, creates a new PEODDCUEDDIFFPELEVELSETTING or raises the existing
%      singleton*.
%
%      H = PEODDCUEDDIFFPELEVELSETTING returns the handle to a new PEODDCUEDDIFFPELEVELSETTING or the handle to
%      the existing singleton*.
%
%      PEODDCUEDDIFFPELEVELSETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEODDCUEDDIFFPELEVELSETTING.M with the given input arguments.
%
%      PEODDCUEDDIFFPELEVELSETTING('Property','Value',...) creates a new PEODDCUEDDIFFPELEVELSETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddCuedDiffPELevelSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddCuedDiffPELevelSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddCuedDiffPELevelSetting

% Last Modified by GUIDE v2.5 24-Sep-2022 10:28:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddCuedDiffPELevelSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddCuedDiffPELevelSetting_OutputFcn, ...
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


% --- Executes just before PEOddCuedDiffPELevelSetting is made visible.
function PEOddCuedDiffPELevelSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddCuedDiffPELevelSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.S1frequency, 'string', num2str(paramsLoad.S1frequency));
        set(handles.S1FreqRatio, 'string', num2str(paramsLoad.S1FreqRatio));
        set(handles.S1LocRatio, 'string', num2str(paramsLoad.S1LocRatio));
        set(handles.S2frequency, 'string', num2str(paramsLoad.S2frequency));
        set(handles.S2FreqRatio, 'string', num2str(paramsLoad.S2FreqRatio));
        set(handles.S2LocRatio, 'string', num2str(paramsLoad.S2LocRatio));
        set(handles.LocIdx, 'string', num2str(paramsLoad.LocIdx));
        
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddCuedDiffPELevelSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddCuedDiffPELevelSetting wait for user response (see UIRESUME)
uiwait(handles.PEOddDiffPELevelSettingFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddCuedDiffPELevelSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.PEOddDiffPELevelSettingFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
params.S1frequency = str2double(get(handles.S1frequency, 'String'));
params.S1FreqRatio = str2double(get(handles.S1FreqRatio, 'String'));
params.S1LocRatio = str2double(get(handles.S1LocRatio, 'String'));
params.S2frequency = str2double(get(handles.S2frequency, 'String'));
params.S2FreqRatio = str2double(get(handles.S2FreqRatio, 'String'));
params.S2LocRatio = str2double(get(handles.S2LocRatio, 'String'));
params.LocIdx = eval(['[' get(handles.LocIdx, 'string') ']']);
setappdata(handles.PEOddDiffPELevelSettingFig, 'params', params);

uiresume(handles.PEOddDiffPELevelSettingFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.PEOddDiffPELevelSettingFig, 'params', []);
uiresume(handles.PEOddDiffPELevelSettingFig);


function S1frequency_Callback(hObject, eventdata, handles)
% hObject    handle to S1frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1frequency as text
%        str2double(get(hObject,'String')) returns contents of S1frequency as a double


% --- Executes during object creation, after setting all properties.
function S1frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S1FreqRatio_Callback(hObject, eventdata, handles)
% hObject    handle to S1FreqRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1FreqRatio as text
%        str2double(get(hObject,'String')) returns contents of S1FreqRatio as a double


% --- Executes during object creation, after setting all properties.
function S1FreqRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1FreqRatio (see GCBO)
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


% --- Executes when user attempts to close PEOddDiffPELevelSettingFig.
function PEOddDiffPELevelSettingFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PEOddDiffPELevelSettingFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on PEOddDiffPELevelSettingFig or any of its controls.
function PEOddDiffPELevelSettingFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PEOddDiffPELevelSettingFig (see GCBO)
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



function S1LocRatio_Callback(hObject, eventdata, handles)
% hObject    handle to S1LocRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1LocRatio as text
%        str2double(get(hObject,'String')) returns contents of S1LocRatio as a double


% --- Executes during object creation, after setting all properties.
function S1LocRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1LocRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S2frequency_Callback(hObject, eventdata, handles)
% hObject    handle to S2frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S2frequency as text
%        str2double(get(hObject,'String')) returns contents of S2frequency as a double


% --- Executes during object creation, after setting all properties.
function S2frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S2FreqRatio_Callback(hObject, eventdata, handles)
% hObject    handle to S2FreqRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S2FreqRatio as text
%        str2double(get(hObject,'String')) returns contents of S2FreqRatio as a double


% --- Executes during object creation, after setting all properties.
function S2FreqRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2FreqRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S2LocRatio_Callback(hObject, eventdata, handles)
% hObject    handle to S2LocRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S2LocRatio as text
%        str2double(get(hObject,'String')) returns contents of S2LocRatio as a double


% --- Executes during object creation, after setting all properties.
function S2LocRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2LocRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LocIdx_Callback(hObject, eventdata, handles)
% hObject    handle to LocIdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LocIdx as text
%        str2double(get(hObject,'String')) returns contents of LocIdx as a double


% --- Executes during object creation, after setting all properties.
function LocIdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LocIdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
