function varargout = PCController(varargin)
% PCCONTROLLER MATLAB code for PCController.fig
%      PCCONTROLLER, by itself, creates a new PCCONTROLLER or raises the existing
%      singleton*.
%
%      H = PCCONTROLLER returns the handle to a new PCCONTROLLER or the handle to
%      the existing singleton*.
%
%      PCCONTROLLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCCONTROLLER.M with the given input arguments.
%
%      PCCONTROLLER('Property','Value',...) creates a new PCCONTROLLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCController_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCController_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCController

% Last Modified by GUIDE v2.5 04-Jun-2015 17:09:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCController_OpeningFcn, ...
                   'gui_OutputFcn',  @PCController_OutputFcn, ...
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


% --- Executes just before PCController is made visible.
function PCController_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCController (see VARARGIN)

% Choose default command line output for PCController
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCController wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCController_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in SetInitialAngle.
function SetInitialAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Initial_Angle = get(handles.editInitialAngle , 'String');
Initial_Angle = str2num( Initial_Angle );
if rem(Initial_Angle,0.5) ~= 0 
    error('Better input an integer angle')
end
SetRotateAngle(Serial_SGSP , Initial_Anlge/2 ,0.5)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
SetRotateAngle( S_SGSP , 10 ,5)


function editInitialAngle_Callback(hObject, eventdata, handles)
% hObject    handle to editInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInitialAngle as text
%        str2double(get(hObject,'String')) returns contents of editInitialAngle as a double


% --- Executes during object creation, after setting all properties.
function editInitialAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SetAngleResolution.
function SetAngleResolution_Callback(hObject, eventdata, handles)
% hObject    handle to SetAngleResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editAngleResolution_Callback(hObject, eventdata, handles)
% hObject    handle to editAngleResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAngleResolution as text
%        str2double(get(hObject,'String')) returns contents of editAngleResolution as a double


% --- Executes during object creation, after setting all properties.
function editAngleResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAngleResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PerformMea.
function PerformMea_Callback(hObject, eventdata, handles)
% hObject    handle to PerformMea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in MeaPause.
function MeaPause_Callback(hObject, eventdata, handles)
% hObject    handle to MeaPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SetMeaStartAngle.
function SetMeaStartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetMeaStartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SetMeaFinalAngle.
function SetMeaFinalAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetMeaFinalAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SerialConnectSGSP.
function SerialConnectSGSP_Callback(hObject, eventdata, handles)
% hObject    handle to SerialConnectSGSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

S_Objs = get( handles.pushbuttonSerialDetect , 'UserData' );
for i=1:length( S_Objs )
    if S_Objs(1,i).BytesAvailable ~= 0   %读缓冲区清零
        fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );
    end
    fwrite( S_Objs(1,i) , 1 ,'int8' );
    fwrite( S_Objs(1,i) , 1 ,'int8' );
    fwrite( S_Objs(1,i) , 1 ,'int8' );
    fwrite( S_Objs(1,i) , 1 ,'int8' );
    pause(0.2) % 转台反应需要时间
    if S_Objs(1,i).BytesAvailable == ( 33+4 )
        set( handles.SerialConnectSGSP , 'UserData' , S_Objs(1,i) );
        fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );
        set( handles.SerialConnectSGSP , 'Enable','off' );
        msgbox('自动转台串口已连接','自动转台串口');   
    elseif S_Objs(1,i).BytesAvailable ~= 0
        fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
    end
end

% --- Executes on button press in SerialConnectSensor.
function SerialConnectSensor_Callback(hObject, eventdata, handles)
% hObject    handle to SerialConnectSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S_Objs = get( handles.pushbuttonSerialDetect , 'UserData' );
for i=1:length( S_Objs )
    if S_Objs(1,i).BytesAvailable ~= 0      %读缓冲区清零
        fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );
    end
    fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
    fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
    fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
    fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
    pause(0.1) % 由于arduino板子反应较快，所以这里的延时可以不加
    if S_Objs(1,i).BytesAvailable == ( 4*2 )
        set( handles.SerialConnectSensor , 'UserData' , S_Objs(1,i) );
        msgbox('传感器串口已连接','传感器串口');
        set( handles.SerialConnectSensor , 'Enable','off' );
    elseif S_Objs(1,i).BytesAvailable ~= 0
        fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
    end
    
end


% --- Executes on button press in pushbuttonSerialDetect.
function pushbuttonSerialDetect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSerialDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty( get( handles.pushbuttonSerialDetect,'UserData' ))
    S_Info = instrhwinfo('serial');
    if isempty( S_Info.SerialPorts )
         msgbox('没有检测到串口!','串口检测', 'error');
    elseif length( S_Info.SerialPorts )<=1
        msgbox( '串口数目不对，检查是否有仪器没有连接','串口检测','error' );
    else
        S_Ports = S_Info.SerialPorts;
        for i=1:length( S_Ports )
            S_Objs(1,i) = serial( S_Ports{i,1} , 'BaudRate' , 57600 );
            fopen( S_Objs(1,i) );
        end
        set( handles.pushbuttonSerialDetect , 'UserData',S_Objs );
        msgbox('串口已经打开','串口检测');
        set( handles.SerialConnectSensor , 'Enable','on' );
        set( handles.SerialConnectSGSP , 'Enable','on' );
    end
else
    S_Objs = get( handles.pushbuttonSerialDetect,'UserData' );
    for i=1:length( S_Objs )
        fclose( S_Objs(1,i) );
        delete( S_Objs(1,i) );
        clear S_Objs(1,i);
    end    
    S_Info = instrhwinfo('serial');
    if isempty( S_Info.SerialPorts )
         msgbox('没有检测到串口!','串口检测', 'error');
    elseif length( S_Info.SerialPorts )<=1
        msgbox( '串口数目不对，检查是否有仪器没有连接','串口检测','error' );
    else
        S_Ports = S_Info.SerialPorts;
        for i=1:length( S_Ports )
            S_Objs(1,i) = serial( S_Ports{i,1} , 'BaudRate' , 57600 );
            fopen( S_Objs(1,i) );
        end
        set( handles.pushbuttonSerialDetect , 'UserData',S_Objs );
        msgbox('串口已经打开','串口检测');
        set( handles.SerialConnectSensor , 'Enable','on' );
        set( handles.SerialConnectSGSP , 'Enable','on' );
    end
end


% --- Executes on button press in pushbuttonStopMea.
function pushbuttonStopMea_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStopMea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonClose.
function pushbuttonClose_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('是否确认关闭','关闭确认','是','否','是');
if strcmp(button,'是')
    S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
    S_Sensor = get( handles.SerialConnectSensor , 'UserData' );
    fclose( S_SGSP );fclose( S_Sensor );
    delete( S_SGSP );delete( S_Sensor );
    clear S_SGSP S_Sensor
    close all
else
    return;
end


% --- Executes during object creation, after setting all properties.
function SerialConnectSGSP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SerialConnectSGSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function SerialConnectSensor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SerialConnectSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
