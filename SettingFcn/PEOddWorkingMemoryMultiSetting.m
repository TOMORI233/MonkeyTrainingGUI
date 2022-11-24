function varargout = PEOddWorkingMemoryMultiSetting(varargin)
% PEODDWORKINGMEMORYMULTISETTING MATLAB code for PEOddWorkingMemoryMultiSetting.fig
%      PEODDWORKINGMEMORYMULTISETTING, by itself, creates a new PEODDWORKINGMEMORYMULTISETTING or raises the existing
%      singleton*.
%
%      H = PEODDWORKINGMEMORYMULTISETTING returns the handle to a new PEODDWORKINGMEMORYMULTISETTING or the handle to
%      the existing singleton*.
%
%      PEODDWORKINGMEMORYMULTISETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEODDWORKINGMEMORYMULTISETTING.M with the given input arguments.
%
%      PEODDWORKINGMEMORYMULTISETTING('Property','Value',...) creates a new PEODDWORKINGMEMORYMULTISETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PEOddWorkingMemoryMultiSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PEOddWorkingMemoryMultiSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PEOddWorkingMemoryMultiSetting

% Last Modified by GUIDE v2.5 07-Nov-2022 14:55:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PEOddWorkingMemoryMultiSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @PEOddWorkingMemoryMultiSetting_OutputFcn, ...
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


% --- Executes just before PEOddWorkingMemoryMultiSetting is made visible.
function PEOddWorkingMemoryMultiSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PEOddWorkingMemoryMultiSetting (see VARARGIN)

if ~isempty(varargin)
    paramsLoad = varargin{1};
    try
        set(handles.lastStdToDev, 'string', num2str(paramsLoad.lastStdToDev));
        set(handles.Freq1, 'string', num2str(paramsLoad.Freq1));
        set(handles.Freq2, 'string', num2str(paramsLoad.Freq2));
        set(handles.Freq3, 'string', num2str(paramsLoad.Freq3));
        set(handles.Freq4, 'string', num2str(paramsLoad.Freq4));
        set(handles.ratioControl1, 'string', num2str(rats(paramsLoad.ratioControl1, 4)));
        set(handles.ratioControl2, 'string', num2str(rats(paramsLoad.ratioControl2, 4)));
        set(handles.ratioControl3, 'string', num2str(rats(paramsLoad.ratioControl3, 4)));
        set(handles.ratioControl4, 'string', num2str(rats(paramsLoad.ratioControl4, 4)));
        set(handles.fProp1, 'string', num2str(rats(paramsLoad.fProp1, 8)));
        set(handles.fProp2, 'string', num2str(rats(paramsLoad.fProp2, 8)));
        set(handles.fProp3, 'string', num2str(rats(paramsLoad.fProp3, 8)));
        set(handles.fProp4, 'string', num2str(rats(paramsLoad.fProp4, 8)));
    catch
%         msgbox('Params MISSING!');
    end
end

% Choose default command line output for PEOddWorkingMemoryMultiSetting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PEOddWorkingMemoryMultiSetting wait for user response (see UIRESUME)
uiwait(handles.WoringMemoryMultiFig);


% --- Outputs from this function are returned to the command line.
function varargout = PEOddWorkingMemoryMultiSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = getappdata(handles.WoringMemoryMultiFig, 'params');
delete(hObject);


% --- Executes on button press in buttonOK.
function buttonOK_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)+set(handles.lastStdToDev, 'string', num2str(paramsLoad.lastStdToDev));
params.lastStdToDev = str2double(get(handles.lastStdToDev, 'String'));
params.Freq1 = str2double(get(handles.Freq1, 'String'));
params.Freq2 = str2double(get(handles.Freq2, 'String'));
params.Freq3 = str2double(get(handles.Freq3, 'String'));
params.Freq4 = str2double(get(handles.Freq4, 'String'));
params.ratioControl1 = eval(['[' get(handles.ratioControl1, 'string') ']']);
params.ratioControl2 = eval(['[' get(handles.ratioControl2, 'string') ']']);
params.ratioControl3 = eval(['[' get(handles.ratioControl3, 'string') ']']);
params.ratioControl4 = eval(['[' get(handles.ratioControl4, 'string') ']']);
params.fProp1 = eval(['[' get(handles.fProp1, 'string') ']']);
params.fProp2 = eval(['[' get(handles.fProp2, 'string') ']']);
params.fProp3 = eval(['[' get(handles.fProp3, 'string') ']']);
params.fProp4 = eval(['[' get(handles.fProp4, 'string') ']']);

setappdata(handles.WoringMemoryMultiFig, 'params', params);
uiresume(handles.WoringMemoryMultiFig);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.WoringMemoryMultiFig, 'params', []);
uiresume(handles.WoringMemoryMultiFig);


function Freq1_Callback(hObject, eventdata, handles)
% hObject    handle to Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq1 as text
%        str2double(get(hObject,'String')) returns contents of Freq1 as a double


% --- Executes during object creation, after setting all properties.
function Freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Freq2_Callback(hObject, eventdata, handles)
% hObject    handle to Freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq2 as text
%        str2double(get(hObject,'String')) returns contents of Freq2 as a double


% --- Executes during object creation, after setting all properties.
function Freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq2 (see GCBO)
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


% --- Executes when user attempts to close WoringMemoryMultiFig.
function WoringMemoryMultiFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to WoringMemoryMultiFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    buttonCancel_Callback(hObject, eventdata, handles);
catch
    delete(hObject);
end


% --- Executes on key press with focus on WoringMemoryMultiFig or any of its controls.
function WoringMemoryMultiFig_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to WoringMemoryMultiFig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'return')
    buttonOK_Callback(hObject, eventdata, handles);
end



function Freq3_Callback(hObject, eventdata, handles)
% hObject    handle to Freq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq3 as text
%        str2double(get(hObject,'String')) returns contents of Freq3 as a double


% --- Executes during object creation, after setting all properties.
function Freq3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Freq4_Callback(hObject, eventdata, handles)
% hObject    handle to Freq4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq4 as text
%        str2double(get(hObject,'String')) returns contents of Freq4 as a double


% --- Executes during object creation, after setting all properties.
function Freq4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioControl1_Callback(hObject, eventdata, handles)
% hObject    handle to ratioControl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioControl1 as text
%        str2double(get(hObject,'String')) returns contents of ratioControl1 as a double


% --- Executes during object creation, after setting all properties.
function ratioControl1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioControl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioControl2_Callback(hObject, eventdata, handles)
% hObject    handle to ratioControl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioControl2 as text
%        str2double(get(hObject,'String')) returns contents of ratioControl2 as a double


% --- Executes during object creation, after setting all properties.
function ratioControl2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioControl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioControl3_Callback(hObject, eventdata, handles)
% hObject    handle to ratioControl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioControl3 as text
%        str2double(get(hObject,'String')) returns contents of ratioControl3 as a double


% --- Executes during object creation, after setting all properties.
function ratioControl3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioControl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioControl4_Callback(hObject, eventdata, handles)
% hObject    handle to ratioControl4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioControl4 as text
%        str2double(get(hObject,'String')) returns contents of ratioControl4 as a double


% --- Executes during object creation, after setting all properties.
function ratioControl4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioControl4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fProp1_Callback(hObject, eventdata, handles)
% hObject    handle to fProp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fProp1 as text
%        str2double(get(hObject,'String')) returns contents of fProp1 as a double


% --- Executes during object creation, after setting all properties.
function fProp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fProp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fProp2_Callback(hObject, eventdata, handles)
% hObject    handle to fProp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fProp2 as text
%        str2double(get(hObject,'String')) returns contents of fProp2 as a double


% --- Executes during object creation, after setting all properties.
function fProp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fProp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fProp3_Callback(hObject, eventdata, handles)
% hObject    handle to fProp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fProp3 as text
%        str2double(get(hObject,'String')) returns contents of fProp3 as a double


% --- Executes during object creation, after setting all properties.
function fProp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fProp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fProp4_Callback(hObject, eventdata, handles)
% hObject    handle to fProp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fProp4 as text
%        str2double(get(hObject,'String')) returns contents of fProp4 as a double


% --- Executes during object creation, after setting all properties.
function fProp4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fProp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lastStdToDev_Callback(hObject, eventdata, handles)
% hObject    handle to lastStdToDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lastStdToDev as text
%        str2double(get(hObject,'String')) returns contents of lastStdToDev as a double


% --- Executes during object creation, after setting all properties.
function lastStdToDev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lastStdToDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
