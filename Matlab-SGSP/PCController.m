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

% Last Modified by GUIDE v2.5 12-Jun-2015 11:31:04

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

% 初始化坐标系
handles.hPlot = [];
handles.Plot_Scale = 10;
axis( handles.PlotAxes , [0 handles.Plot_Scale 0 5 ]);  
handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];

set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));

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
guidata( hObject , handles );
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
      set( handles.EditAngleResolution , 'Enable', 'on');
   else
      set( handles.EditAngleResolution , 'Enable', 'off');
      EditAngleResolution = str2num( get( handles.EditAngleResolution , 'String' ) );
      if rem( EditAngleResolution ,0.005) ~= 0
         msgbox('请输入一个0.005的整数倍的分辨率','设定角度分辨率');
         set( handles.EditAngleResolution , 'Enable', 'on');
      end
   end
end
guidata(hObject,handles);
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

set( handles.PerformMea , 'UserData' , 1 );  % 1代表执行测量，0代表停止测量，置零将在停止测量处执行

% 获得串口对象
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );
if S_SGSP.BytesAvailable
    fread( S_SGSP , S_SGSP.BytesAvailable );%读缓冲区清零
end
if S_Sensor.BytesAvailable
    fread( S_Sensor , S_Sensor.BytesAvailable );%读缓冲区清零
end

% 获得位置信息
Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
% 获取以往电压信息
if isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    Voltage_History = [];
    set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History );
end


% 获得测量的参数
Start_Angle = str2num( get( handles.EditMeaStartAngle , 'String') );
Final_Angle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );

Mea_Step_Angle = 1 ;

while( get( handles.PerformMea , 'UserData' ) )
    if Start_Angle < Final_Angle
        % 正常测量
        % 1> 步进1度
        Dat = RotateAndRecord( S_SGSP , handles.Rotate_Scan_Rate , S_Sensor );
        % 1.1> 获得一组测量的数据进行处理一下转成电压值
        Total_Num = length( Dat )/2;
        i=1:1:Total_Num;
        Voltage_Part( 1,i ) = (Dat( 1,2*i-1 )*256 + Dat( 1,2*i ))/1023*5;
        % 1.2> 添加到整体的电压值中
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
           
        Voltage_History.Volt( 1 , (length( Voltage_History.Volt )+1):(length( Voltage_History.Volt )+Total_Num) ) = Voltage_Part;
        Voltage_Part_Time = (length( Voltage_History.Time )+1) : (length( Voltage_History.Time )+Total_Num);
        Voltage_Part_Time = Voltage_Part_Time*handles.Sample_Rate;
        Voltage_History.Time( 1 , (length( Voltage_History.Time )+1):(length( Voltage_History.Time )+Total_Num) ) = Voltage_Part_Time;
        % 1.3> 并画至坐标系中 
        if (~isempty( Voltage_History ) ) && ( isempty( handles.hPlot ) )
            handles.hPlot = plot(handles.PlotAxes,Voltage_History.Time , Voltage_History.Volt );
        end
        % 1.3.1 > 如果时间长度没有超过当前时间的范围，则不需要更新，如果超过了才需要更新Moving_X_Axis 
        if length( Voltage_History.Time ) > handles.Moving_X_Axis/handles.Sample_Rate
            handles.Moving_X_Axis( 1 , 1:2 ) = handles.Moving_X_Axis( 1 , 1:2 ) + length( Voltage_Part )*handles.Sample_Rate;
        end
        set( handles.hPlot,'XData',Voltage_History.Time,'YData',Voltage_History.Volt );
        axis( handles.PlotAxes, handles.Moving_X_Axis );    
        Voltage_Part = [];  % 用完要角Voltage_Part 清空，防止其冗余出的长度影响Voltage_History 的更新
        set( handles.ShowCurrentVoltage , 'UserData',Voltage_History);
        
        
        New_Pos_Info = PosInvTranslation( Mea_Step_Angle ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if New_Pos_Info.Current_CyclePostion ~= MotorPos;
            SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
        end
        % 2> 更新位置信息
        Position_Info = New_Pos_Info;
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str(Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));

        % 3> 判断是否到达最大值，恢复起始角
        if Position_Info.Current_Angle >= Final_Angle
            for i=1:1:(Final_Angle-Start_Angle)
                SetRotateUnit( S_SGSP , -1 );
            end
            New_Pos_Info = PosInvTranslation( -(Final_Angle-Start_Angle) ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
            % 2> 更新位置信息
            Position_Info = New_Pos_Info;

            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        
        end    
    elseif Start_Angle > Final_Angle
        % 反向测量
        % 1> 步进1度
        Dat = RotateAndRecord( S_SGSP , -handles.Rotate_Scan_Rate , S_Sensor );
        % 1.1> 获得一组测量的数据进行处理一下转成电压值
        Total_Num = length( Dat )/2;
        i=1:1:Total_Num;
        Voltage_Part( 1,i ) = (Dat( 1,2*i-1 )*256 + Dat( 1,2*i ))/1023*5;
        % 1.2> 添加到整体的电压值中
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');    

        Voltage_History.Volt( 1 , (length( Voltage_History.Volt )+1):(length( Voltage_History.Volt )+Total_Num) ) = Voltage_Part;
        Voltage_Part_Time = (length( Voltage_History.Time )+1) : (length( Voltage_History.Time )+Total_Num);
        Voltage_Part_Time = Voltage_Part_Time*handles.Sample_Rate;
        Voltage_History.Time( 1 , (length( Voltage_History.Time )+1):(length( Voltage_History.Time )+Total_Num) ) = Voltage_Part_Time;
        % 1.3> 并画至坐标系中
        if (~isempty( Voltage_History ) ) && ( isempty( handles.hPlot ) )
            handles.hPlot = plot(handles.PlotAxes,Voltage_History.Time , Voltage_History.Volt );
        end
        
        % 1.3.1 > 如果时间长度没有超过当前现实的范围，则不需要更新，如果超过了才需要更新Moving_X_Axis 
        if length( Voltage_History.Time ) > handles.Moving_X_Axis/handles.Sample_Rate
            handles.Moving_X_Axis( 1 , 1:2 ) = handles.Moving_X_Axis( 1 , 1:2 ) + length( Voltage_Part )*handles.Sample_Rate;
        end
        set( handles.hPlot,'XData',Voltage_History.Time,'YData',Voltage_History.Volt );
        axis( handles.PlotAxes,handles.Moving_X_Axis );  
        
        Voltage_Part = [];  % 用完要角Voltage_Part 清空，防止其冗余出的长度影响Voltage_History 的更新
        set( handles.ShowCurrentVoltage , 'UserData',Voltage_History);
        
        New_Pos_Info = PosInvTranslation( -Mea_Step_Angle ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if New_Pos_Info.Current_CyclePostion ~= MotorPos;
            SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
        end
        % 2> 更新位置信息
        Position_Info = New_Pos_Info;
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
        % 3> 判断是否到达最大值，恢复起始角
        if Position_Info.Current_Angle <= Final_Angle
            for i=1:1:(Start_Angle-Final_Angle)
                SetRotateUnit( S_SGSP , 1 );
            end
            New_Pos_Info = PosInvTranslation( -(Final_Angle-Start_Angle) ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
            % 2> 更新位置信息
            Position_Info = New_Pos_Info.Current_CyclePostion;
            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        
        end
    end
end

if S_SGSP.BytesAvailable
    fread( S_SGSP , S_SGSP.BytesAvailable );%读缓冲区清零
end
if S_Sensor.BytesAvailable
    fread( S_Sensor , S_Sensor.BytesAvailable );%读缓冲区清零
end

guidata(hObject,handles);

function Timer_Callback( hObject , eventdata , handles ) 
% 获得串口对象
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );
% 获得位置信息
Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );

guidata(hObject,handles);



% --- Executes on button press in MeaPause.
function MeaPause_Callback(hObject, eventdata, handles)
% hObject    handle to MeaPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.PerformMea , 'UserData' , 0 );  % 1代表执行测量，0代表停止测量，置零将在停止测量处执行

% --- Executes on button press in SetMeaStartAngle.
function SetMeaStartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetMeaStartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData');
S_Sensor = get( handles.SerialConnectSensor , 'UserData');

% 确认串口对象都已经存在
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('请先确保转台与传感器都已连接好！', '自定义起始角');
else
    % 只要启动了该配置，则之前的数据就要被抹除
    Voltage_History.Volt=[];Voltage_History.Time=[]; 
    handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];
    set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History ); % 由于这里是重新配置测量配置，所以需要将之前的Voltage_History 清零
   
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
            New_Pos_Info = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
                
        elseif Angle_To_Rotate < 0
            % 旋转指定的角度
            for i=1:1:abs(Angle_To_Rotate)
                SetRotateUnit( S_SGSP , -1 );
            end
            New_Pos_Info = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
        end
        % 旋转完成后将 RawPosition 与 CycleFlags写入Position_Info结构体中
        Position_Info = New_Pos_Info;
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
     end
   end
end
guidata( hObject , handles );

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
   % 抹除之前的数据 
   Voltage_History.Volt=[];Voltage_History.Time=[]; 
   set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History ); % 由于这里是重新配置测量配置，所以需要将之前的Voltage_History 清零
   handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];
   
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
guidata( hObject , handles );

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
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
            set( handles.SerialConnectSGSP , 'UserData' , S_Objs(1,i) );
            set( handles.SerialConnectSGSP , 'Enable','off' );
            handles.Rotate_Scan_Rate = 6400;
            msgbox('自动转台串口已连接','自动转台串口');  
            
            % 检测如果都转台和传感器都连接OK，那么Enable设置控件
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % 将设置类的控件全部Enable
                    set( handles.pushbuttonOriginCheck , 'Enable','on' );
                    set( handles.SetInitialAngle , 'Enable','on' );  
                    set( handles.SetMeaStartAngle , 'Enable','on' );  
                   % set( handles.SetAngleResolution , 'Enable','on' );  
                    set( handles.SetMeaFinalAngle , 'Enable','on' );
                    set( handles.PerformMea , 'Enable','on' );  
                    set( handles.MeaPause , 'Enable','on' );  
                    set( handles.pushbuttonStopMea , 'Enable','on' );
            end
            
        elseif S_Objs(1,i).BytesAvailable
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
        end
    end
%else
%    msgbox('自动转台串口已连接，请不要重复连接','自动转台串口');  
%end
guidata( hObject , handles );


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
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零 
            msgbox('传感器串口已连接','传感器串口');
            set( handles.SerialConnectSensor , 'Enable','off' );
            fclose( S_Objs( 1,i ) );
            S_Objs(1,i).InputBufferSize = 10240;        % 将输入缓冲区的大小调整至10240 bytes 以方便接收数据
            % 默认的传感器的采样速率 
            handles.Sample_Rate = 0.01;
            fopen( S_Objs( 1,i ) );
            set( handles.SerialConnectSensor , 'UserData' , S_Objs(1,i) );
            % 开始设定定时器
            % Set_Rotate_Time_Max = 0.13; 
%             Sensor_Time_Max = 0.05;
%             handles.Timer=timer('Period',Sensor_Time_Max,'ExecutionMode','fixedRate', 'TimerFcn',{@Timer_Callback,handles});
            % 检测如果都转台和传感器都连接OK，那么Enable设置控件
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % 将设置类的控件全部Enable
                    set( handles.pushbuttonOriginCheck , 'Enable','on' );
                    set( handles.SetInitialAngle , 'Enable','on' );  
                    set( handles.SetMeaStartAngle , 'Enable','on' );  
                   % set( handles.SetAngleResolution , 'Enable','on' );  
                    set( handles.SetMeaFinalAngle , 'Enable','on' );
                    set( handles.PerformMea , 'Enable','on' );  
                    set( handles.MeaPause , 'Enable','on' );  
                    set( handles.pushbuttonStopMea , 'Enable','on' );
            end
            
        elseif S_Objs(1,i).BytesAvailable
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%读缓冲区清零
        end
    end
guidata( hObject , handles );
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
        %set( handles.SetAngleResolution , 'Enable','off' );  
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
        %set( handles.SetAngleResolution , 'Enable','off' );  
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

set( handles.PerformMea , 'UserData' , 0 );  % 1代表执行测量，0代表停止测量，置零将在停止测量处执行

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles.SerialConnectSensor , 'UserData' );

if S_SGSP.BytesAvailable
            fread( S_SGSP , S_SGSP.BytesAvailable );%读缓冲区清零
end
if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%读缓冲区清零
end

% 获得测量的参数
Start_Angle = str2num( get( handles.EditMeaStartAngle , 'String') );
Final_Angle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );

% 
Roll_Back_Angle = 1 ;

% 是否要保存测量的数据---------------------------?
if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    button=questdlg('是否要保存数据','确认','是','否','是');
    if strcmp(button,'是')
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
        [ name , path ] = uiputfile();
        save( [ path ,name ] , 'Voltage_History' );
    end
end
SetRotateUnit( S_SGSP , -Roll_Back_Angle);
% 
% % 正负转动的标志
% if Position_Info.Current_Angle - Start_Angle ~= 0
%     if Position_Info.Current_Angle - Start_Angle > 0
%         % 回归原位置
%         for i=1:1:(  Position_Info.Current_Angle - Start_Angle  )
%             SetRotateUnit( S_SGSP , -Roll_Back_Angle);
%         end
%         New_Pos_Info = PosInvTranslation(  -Roll_Back_Angle ,Position_Info );
%         MotorPos = MotorReadPos( S_SGSP );
%         if New_Pos_Info.Current_CyclePostion ~= MotorPos;
%             SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
%         end
%     elseif Position_Info.Current_Angle - Start_Angle < 0
%         for i=1:1:(  -Position_Info.Current_Angle + Start_Angle  )
%             SetRotateUnit( S_SGSP , Roll_Back_Angle);
%         end
%         New_Pos_Info = PosInvTranslation(  Roll_Back_Angle ,Position_Info );
%         MotorPos = MotorReadPos( S_SGSP );
%         if New_Pos_Info.Current_CyclePostion ~= MotorPos;
%             SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
%         end
%     end
%     Position_Info = New_Pos_Info;
%     set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
%     set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
%     set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));  
% end 
% 2> 更新位置信息
  
guidata( hObject , handles );

% --- Executes on button press in pushbuttonClose.
function pushbuttonClose_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('是否确认关闭','关闭确认','是','否','是');
if strcmp(button,'是')
    % 是否要保存测量的数据---------------------------?
    if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
        button=questdlg('是否要保存数据','确认','是','否','是');
        if strcmp(button,'是')
            Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
            [ name , path ] = uiputfile();
            save( [ path ,name ] , 'Voltage_History' );
        end
    end
    S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
    S_Sensor = get( handles.SerialConnectSensor , 'UserData' );
   % stop( handles.Timer );
   % delete( handles.Timer );
   % if strcmp(handles.Timer.Running,'off')
   %     stop( handles.Timer );
   %end
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

if S_SGSP.BytesAvailable
            fread( S_SGSP , S_SGSP.BytesAvailable );%读缓冲区清零
end
if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%读缓冲区清零
end

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
                New_Pos_Info = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                    SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
                end
                
             elseif Rotate_Angle < 0
                % 旋转指定的角度
                for i=1:1:abs(Rotate_Angle)
                    SetRotateUnit( S_SGSP , -1 );
                end
                New_Pos_Info = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                    SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
                end
             end
             % 旋转完成后将Position_Info结构体更新为New_Pos_Info
            Position_Info = New_Pos_Info;
            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
            
         end
         
     end
     
     if S_SGSP.BytesAvailable
            fread( S_SGSP , S_SGSP.BytesAvailable );%读缓冲区清零
     end
     if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%读缓冲区清零
     end
end
guidata(hObject,handles);

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


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function PlotAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlotAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate PlotAxes


% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)
% hObject    handle to SaveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 是否要保存测量的数据---------------------------?
if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    button=questdlg('是否要保存数据','确认','是','否','是');
    if strcmp(button,'是')
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
        [ name , path ] = uiputfile();
        save( [ path ,name ] , 'Voltage_History' );
    end
end
guidata(hObject,handles);
