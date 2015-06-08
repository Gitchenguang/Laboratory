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

% Last Modified by GUIDE v2.5 08-Jun-2015 21:37:52

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


% --- Executes on button press in pushbuttonOriginCheck.
function pushbuttonOriginCheck_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOriginCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );

%***********注释中的代码需要零件装配好才能使用，下面的这一段为临时使用************
SetRotateUnit( S_SGSP , 0 );
MotorPos = MotorReadPos( S_SGSP );

Position_Info.Origin_CyclePostion = MotorPos;
Position_Info.Origin_Angle = 0; 

Position_Info.Current_CyclePostion = MotorPos;
Position_Info.Current_Angle = 0; 

Position_Info.CycleFlag = 0;

set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
%*****************************************************************************


% % Basic Variables ^_^搜索角像钱的分值
% SearchAngle = [ 5 3 2 1 0.5 0.3 0.2 0.1 0.05 0.03 0.01 ];
% Angle_Scale_Ind = 1;
% 
% % 开始进行坐标修正
% % 1> 读取当前Photo_Sensor的电压信息，记录于ind==2位置处 Sensor_V=[ 反向读数 中间读数 正向读数 临时运算缓冲区 ]
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,2 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% % 2> 转台正向旋转2.5度，记录电压值V于Sensor_V ind==3位置处
% SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,3 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% % 3> 转台相对当前位置反向旋转5度，并记录电压值V于ind==1位置处
% SetRotateUnit( S_SGSP , -SearchAngle( Angle_Scale_Ind ) );
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,1 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %转台复中位
% % 4> 判断V0、V1、V_1的关系
% while (Sensor_V(1,2)-Sensor_V(1,3))<0 || (Sensor_V(1,2)-Sensor_V(1,1))<0 || Angle_Scacle_Ind<length( SearchAngle ) 
%     if (Sensor_V(1,2)-Sensor_V(1,3))<0
%         SetRotateUnit( S_SGSP , rand(1)*SearchAngle( Angle_Scale_Ind )/2 );
%         % 进行中点采样，正向采样，反向采样并回复中位
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,2 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,3 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , -SearchAngle( Angle_Scale_Ind ) );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,1 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %转台复中位
%         
%     elseif (Sensor_V(1,2)-Sensor_V(1,1))<0
%         SetRotateUnit( S_SGSP , -rand(1)*SearchAngle( Angle_Scale_Ind )/2 );
%         % 进行中点采样，正向采样，反向采样并回复中位
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,2 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,3 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , -SearchAngle( Angle_Scale_Ind ) );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,1 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %转台复中位
%         
%     elseif (Sensor_V(1,2)-Sensor_V(1,3))>=0 && (Sensor_V(1,2)-Sensor_V(1,1))>=0
%         if Angle_Scale_Ind < length( SearchAngle )   % 缩小角度搜索范围
%             Angle_Scale_Ind = Angle_Scale_Ind + 1;
%         end
%         
%         if (Sensor_V(1,3)-Sensor_V(1,1))>0
%             SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
%         elseif (Sensor_V(1,3)-Sensor_V(1,1))<0
%             SetRotateUnit( S_SGSP , SearchAngle( -Angle_Scale_Ind )/2 );
%         end
%         % 进行中点采样，正向采样，反向采样并回复中位
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,2 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,3 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , -SearchAngle( Angle_Scale_Ind ) );
%         for i=1:3
%             fwrite( S_Sensor , 0 , 'int8' );
%             Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%             Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
%         end
%         Sensor_V( 1,1 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %转台复中位
%     end
% end
% 
% MotorPos = MotorReadPos( S_SGSP );
% % Position_Info 五个域：转台原点原始坐标  转台原始角度 转台当前原始坐标 转台当前角度坐标  坐标周期标志
% Position_Info.Origin_CyclePostion = MotorPos;
% Position_Info.Origin_Angle = 0; 

% Position_Info.Current_CyclePostion = MotorPos;
% Position_Info.Current_Angle = 0; 

% Position_Info.CycleFlag = 0;
% set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );

function EditAnyRoateAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EditAnyRoateAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditAnyRoateAngle as text
%        str2double(get(hObject,'String')) returns contents of EditAnyRoateAngle as a double


% --- Executes during object creation, after setting all properties.
function EditAnyRoateAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditAnyRoateAngle (see GCBO)
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

if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('请先确保转台与传感器都已连接好！', '设定角度分辨率');
else
   EditAngleResolution_Status = get(handles.EditAngleResolution , 'Enable');
   if strcmp(EditAngleResolution_Status , 'off')
      set( handles.EditAnyRoateAngle , 'Enable', 'on');
   else
      set( handles.EditAngleResolution , 'Enable', 'off');
      EditAngleResolution = str2num( get( handles.EditAngleResolution , 'String' ) );
      if rem( EditAngleResolution ,0.005) ~= 0
         msgbox('请输入一个0.005的整数倍的分辨率','设定角度分辨率');
         set( handles.EditAngleResolution , 'Enable', 'on');
      end
   end
end

function EditAngleResolution_Callback(hObject, eventdata, handles)
% hObject    handle to EditAngleResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditAngleResolution as text
%        str2double(get(hObject,'String')) returns contents of EditAngleResolution as a double


% --- Executes during object creation, after setting all properties.
function EditAngleResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditAngleResolution (see GCBO)
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

% 获得测量的参数
Start_Angle = str2num( get( handles.EditMeaStartAngle , 'String') );
Angle_Resolution = str2num( get( handles.EditAngleResolution , 'String') );
Final_Angle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );
% 开始设定定时器
Sensor_Time_Max = 0.15;
Set_Rotate_Time_Max = 0.13; 
Angle_Resolution_Time =  Angle_Resolution/0.005*0.015;

Timer_Period = Angle_Resolution_Time + Sensor_Time_Max + Set_Rotate_Time_Max ;
handles.Timer=timer('Period',Timer_Period,'ExecutionMode','fixedRate', 'TimerFcn',{@Timer_Callback,handles});

handles.Start_Angle = Start_Angle;
handles.Angle_Resolution = Angle_Resolution;
handles.Final_Angle  = Final_Angle;

start( handles.Timer );

guidata(hObject,handles);

function Timer_Callback( hObject , eventdata , handles ) 
% 获得串口对象
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );
% 获得位置信息
Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
% 判断是正向测量还是反向测量
if handles.Start_Angle < handles.Final_Angle
    % 正常测量
    % 1> 步进一个Resolution 角度
    SetRotateUnit( S_SGSP , handles.Angle_Resolution );
    [ CurrentRawPos , CycleFlag ] = PosInvTranslation( handles.Angle_Resolution ,Position_Info );
    MotorPos = MotorReadPos( S_SGSP );
    if CurrentRawPos ~= MotorPos;
        SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
    end
    % 2> 更新位置信息
    Position_Info.Current_CyclePostion = CurrentRawPos;
    Position_Info.Current_Angle = handles.Angle_Resolution + Position_Info.Current_Angle;
    Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 
            
    set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
    set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
    set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
    
    % 3> 判断是否到达最大值，恢复起始角
    if Position_Info.Current_Angle >= handles.Final_Angle
        % 停止定时器
        stop( handles.Timer );
        for i=1:1:(handles.Final_Angle-handles.Start_Angle)
            SetRotateUnit( S_SGSP , -1 );
        end
        [ CurrentRawPos , CycleFlag ] = PosInvTranslation( -(handles.Final_Angle-handles.Start_Angle) ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if CurrentRawPos ~= MotorPos;
            SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
        end
        % 2> 更新位置信息
        Position_Info.Current_CyclePostion = CurrentRawPos;
        Position_Info.Current_Angle = -(handles.Final_Angle-handles.Start_Angle) + Position_Info.Current_Angle;
        Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 

        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        

        % 重新启动定时器
        start( handles.Timer );
    end    
elseif handles.Start_Angle > handles.Final_Angle
    % 反向测量
    % 1> 步进一个 负的 Resolution 角度
    SetRotateUnit( S_SGSP , -handles.Angle_Resolution );
    [ CurrentRawPos , CycleFlag ] = PosInvTranslation( -handles.Angle_Resolution ,Position_Info );
    MotorPos = MotorReadPos( S_SGSP );
    if CurrentRawPos ~= MotorPos;
        SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
    end
    % 2> 更新位置信息
    Position_Info.Current_CyclePostion = CurrentRawPos;
    Position_Info.Current_Angle = -handles.Angle_Resolution + Position_Info.Current_Angle;
    Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 
            
    set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
    set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
    set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
    % 3> 判断是否到达最大值，恢复起始角
    if Position_Info.Current_Angle <= handles.Final_Angle
        % 停止定时器
        stop( handles.Timer );
        for i=1:1:(handles.Start_Angle-handles.Final_Angle)
            SetRotateUnit( S_SGSP , 1 );
        end
        [ CurrentRawPos , CycleFlag ] = PosInvTranslation( -(handles.Final_Angle-handles.Start_Angle) ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if CurrentRawPos ~= MotorPos;
            SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
        end
        % 2> 更新位置信息
        Position_Info.Current_CyclePostion = CurrentRawPos;
        Position_Info.Current_Angle = -(handles.Final_Angle-handles.Start_Angle) + Position_Info.Current_Angle;
        Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 

        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        

        % 重新启动定时器
        start( handles.Timer );
    end
end
guidata(hObject,handles);



% --- Executes on button press in MeaPause.
function MeaPause_Callback(hObject, eventdata, handles)
% hObject    handle to MeaPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MeaTimer = handles.Timer;
if strcmp(MeaTimer.Running,'off')
    start(handles.Timer);
elseif strcmp(MeaTimer.Running,'on')
    stop(handles.Timer);
end

% --- Executes on button press in SetMeaStartAngle.
function SetMeaStartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetMeaStartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData');
% 确认串口对象都已经存在
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('请先确保转台与传感器都已连接好！', '自定义起始角');
else
   EditMeaStartAngle_Status = get(handles.EditMeaStartAngle , 'Enable');
   if strcmp(EditMeaStartAngle_Status , 'off')
      set( handles.EditMeaStartAngle , 'Enable', 'on');
   else
      set( handles.EditMeaStartAngle , 'Enable', 'off');
      EditMeaStartAngle = str2num( get( handles.EditMeaStartAngle , 'String' ) );
      if rem( EditMeaStartAngle ,1) ~= 0
         msgbox('请输入一个整数的角度值','设定起始角');
         set( handles.EditMeaStartAngle , 'Enable', 'on');
      else      
      % 旋转至该角度
      Angle_To_Rotate = EditMeaStartAngle - Position_Info.Current_Angle;
        if Angle_To_Rotate >= 0
            % 旋转指定的角度 
            for i=1:1:Angle_To_Rotate
               SetRotateUnit( S_SGSP , 1 );
            end
            % 旋转后，记录当前旋转的角度的值包括原始位置值与CycleFlag值，并适当修正
            [ CurrentRawPos , CycleFlag ] = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if CurrentRawPos ~= MotorPos;
                SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
            end
                
        elseif Angle_To_Rotate < 0
            % 旋转指定的角度
            for i=1:1:abs(Angle_To_Rotate)
                SetRotateUnit( S_SGSP , -1 );
            end
            [ CurrentRawPos , CycleFlag ] = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if CurrentRawPos ~= MotorPos;
                SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
            end
        end
        % 旋转完成后将 RawPosition 与 CycleFlags写入Position_Info结构体中
        Position_Info.Current_CyclePostion = CurrentRawPos;
        Position_Info.Current_Angle = Angle_To_Rotate+Position_Info.Current_Angle;
        Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag;    
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        
     end
   end
end


function EditMeaStartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EditMeaStartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditMeaStartAngle as text
%        str2double(get(hObject,'String')) returns contents of EditMeaStartAngle as a double


% --- Executes during object creation, after setting all properties.
function EditMeaStartAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMeaStartAngle (see GCBO)
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

% 确认串口对象都已经存在
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('请先确保转台与传感器都已连接好！', '测量终止角');
else
   EditMeaFinalAngle_Status = get(handles.EditMeaFinalAngle , 'Enable');
   if strcmp(EditMeaFinalAngle_Status , 'off')
      set( handles.EditMeaFinalAngle , 'Enable', 'on');
   else
      set( handles.EditMeaFinalAngle , 'Enable', 'off');
      EditMeaFinalAngle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );
      if rem( EditMeaFinalAngle ,1) ~= 0
         msgbox('请输入一个整数的角度值','测量终止角');
         set( handles.EditMeaFinalAngle , 'Enable', 'on');
      end
   end
end

function EditMeaFinalAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EditMeaFinalAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditMeaFinalAngle as text
%        str2double(get(hObject,'String')) returns contents of EditMeaFinalAngle as a double


% --- Executes during object creation, after setting all properties.
function EditMeaFinalAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMeaFinalAngle (see GCBO)
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
%if isempty( get( handles.SerialConnectSGSP , 'UserData' ) )  % 判断UserData是否为空，空的话继续，非空则说明已经连接好，不用再连接
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
            
            % 检测如果都转台和传感器都连接OK，那么Enable设置控件
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % 将设置类的控件全部Enable
                    set( handles.pushbuttonOriginCheck , 'Enable','on' );
                    set( handles.SetInitialAngle , 'Enable','on' );  
                    set( handles.SetMeaStartAngle , 'Enable','on' );  
                    set( handles.SetAngleResolution , 'Enable','on' );  
                    set( handles.SetMeaFinalAngle , 'Enable','on' );
                    set( handles.PerformMea , 'Enable','on' );  
                    set( handles.MeaPause , 'Enable','on' );  
                    set( handles.pushbuttonStopMea , 'Enable','on' );
            end
            
        elseif S_Objs(1,i).BytesAvailable ~= 0
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
        end
    end
%else
%    msgbox('自动转台串口已连接，请不要重复连接','自动转台串口');  
%end



% --- Executes on button press in SerialConnectSensor.
function SerialConnectSensor_Callback(hObject, eventdata, handles)
% hObject    handle to SerialConnectSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%if isempty( get( handles.SerialConnectSensor , 'UserData' ) )
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
            
            % 检测如果都转台和传感器都连接OK，那么Enable设置控件
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % 将设置类的控件全部Enable
                    set( handles.pushbuttonOriginCheck , 'Enable','on' );
                    set( handles.SetInitialAngle , 'Enable','on' );  
                    set( handles.SetMeaStartAngle , 'Enable','on' );  
                    set( handles.SetAngleResolution , 'Enable','on' );  
                    set( handles.SetMeaFinalAngle , 'Enable','on' );
                    set( handles.PerformMea , 'Enable','on' );  
                    set( handles.MeaPause , 'Enable','on' );  
                    set( handles.pushbuttonStopMea , 'Enable','on' );
            end
            
        elseif S_Objs(1,i).BytesAvailable ~= 0
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
        end
    end
%else
%    msgbox('传感器串口已连接，请不要重复连接','传感器串口');
%end

% --- Executes on button press in pushbuttonSerialDetect.
function pushbuttonSerialDetect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSerialDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 如果之前没有检测过，那么UserData应该为空，否则要先清除
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
        
        % 将设置类的控件全部Disable
        set( handles.pushbuttonOriginCheck , 'Enable','off' );
        set( handles.SetInitialAngle , 'Enable','off' );  
        set( handles.SetMeaStartAngle , 'Enable','off' );  
        set( handles.SetAngleResolution , 'Enable','off' );  
        set( handles.SetMeaFinalAngle , 'Enable','off' );
        set( handles.PerformMea , 'Enable','off' );  
        set( handles.MeaPause , 'Enable','off' );  
        set( handles.pushbuttonStopMea , 'Enable','off' );
        
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
        set( handles.pushbuttonSerialDetect , 'UserData',S_Objs );   % 串口程序先盛放在此Userdata中用于后续把得到的对应的串口对象分派给每个仪器的串口连接控件的的UserData
        msgbox('串口已经打开','串口检测');
        set( handles.SerialConnectSensor , 'Enable','on' );   
        set( handles.SerialConnectSGSP , 'Enable','on' );
        
        % 将设置类的控件全部Disable
        set( handles.pushbuttonOriginCheck , 'Enable','off' );
        set( handles.SetInitialAngle , 'Enable','off' );  
        set( handles.SetMeaStartAngle , 'Enable','off' );  
        set( handles.SetAngleResolution , 'Enable','off' );  
        set( handles.SetMeaFinalAngle , 'Enable','off' );
        set( handles.PerformMea , 'Enable','off' );  
        set( handles.MeaPause , 'Enable','off' );  
        set( handles.pushbuttonStopMea , 'Enable','off' );
        
    end
end


% --- Executes on button press in pushbuttonStopMea.
function pushbuttonStopMea_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStopMea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop( handles.Timer);
delete( handles.Timer );

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles.SerialConnectSensor , 'UserData' );

% handles.Start_Angle = Start_Angle;
% handles.Angle_Resolution = Angle_Resolution;
% handles.Final_Angle  = Final_Angle;
% 正负转动的标志
Flag = abs(Position_Info.Current_Angle - handles.Start_Angle)/(Position_Info.Current_Angle - handles.Start_Angle);

for i=1:1:( abs( (Position_Info.Current_Angle - handles.Start_Angle)/handles.Angle_Resolution ) )
    SetRotateUnit( S_SGSP , -handles.Angle_Resolution*Flag );
    [ CurrentRawPos , CycleFlag ] = PosInvTranslation(  -handles.Angle_Resolution*Flag ,Position_Info );
    MotorPos = MotorReadPos( S_SGSP );
    if CurrentRawPos ~= MotorPos;
        SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
    end
    % 2> 更新位置信息
    Position_Info.Current_CyclePostion = CurrentRawPos;
    Position_Info.Current_Angle = -handles.Angle_Resolution*Flag + Position_Info.Current_Angle;
    Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 
            
    set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
    set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
    set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));    
end

% --- Executes on button press in pushbuttonClose.
function pushbuttonClose_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('是否确认关闭','关闭确认','是','否','是');
if strcmp(button,'是')
    S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
    S_Sensor = get( handles.SerialConnectSensor , 'UserData' );
    stop( handles.Timer );
    delete( handles.Timer );
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


% --- Executes on button press in SetInitialAngle.
function SetInitialAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles.SerialConnectSensor , 'UserData' );

% 确认串口对象都已经存在
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('请先确保转台与传感器都已连接好！', '自定义旋转角');
else
     EditAnyRotateAngle_Status = get( handles.EditAnyRoateAngle , 'Enable' );
     if strcmp(EditAnyRotateAngle_Status , 'off')
         set( handles.EditAnyRoateAngle , 'Enable', 'on');
     else
         set( handles.EditAnyRoateAngle , 'Enable', 'off');
         Rotate_Angle =str2num( get( handles.EditAnyRoateAngle , 'String') );
         if rem( Rotate_Angle ,1) ~= 0
             msgbox('请输入一个整数的角度值','自定义旋转角');
             set( handles.EditAnyRoateAngle , 'Enable', 'on');
         else 
             if Rotate_Angle >= 0
                % 旋转指定的角度 
                for i=1:1:Rotate_Angle
                    SetRotateUnit( S_SGSP , 1 );
                end
                % 旋转后，记录当前旋转的角度的值包括原始位置值与CycleFlag值，并适当修正
                [ CurrentRawPos , CycleFlag ] = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if CurrentRawPos ~= MotorPos;
                    SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
                end
                
             elseif Rotate_Angle < 0
                % 旋转指定的角度
                for i=1:1:abs(Rotate_Angle)
                    SetRotateUnit( S_SGSP , -1 );
                end
                [ CurrentRawPos , CycleFlag ] = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if CurrentRawPos ~= MotorPos;
                    SetRotateSteps( S_SGSP , CurrentRawPos-MotorPos );
                end
             end
             % 旋转完成后将 RawPosition 与 CycleFlags写入Position_Info结构体中
            Position_Info.Current_CyclePostion = CurrentRawPos;
            Position_Info.Current_Angle = Rotate_Angle + Position_Info.Current_Angle;
            Position_Info.CycleFlag = CycleFlag + Position_Info.CycleFlag; 
            
            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
            
         end
         
     end
end



function ShowCurrentVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to ShowCurrentVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShowCurrentVoltage as text
%        str2double(get(hObject,'String')) returns contents of ShowCurrentVoltage as a double


% --- Executes during object creation, after setting all properties.
function ShowCurrentVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowCurrentVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ShowCurrentAngle_Callback(hObject, eventdata, handles)
% hObject    handle to ShowCurrentAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShowCurrentAngle as text
%        str2double(get(hObject,'String')) returns contents of ShowCurrentAngle as a double


% --- Executes during object creation, after setting all properties.
function ShowCurrentAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowCurrentAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
