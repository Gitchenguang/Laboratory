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

%***********ע���еĴ�����Ҫ���װ��ò���ʹ�ã��������һ��Ϊ��ʱʹ��************
SetRotateUnit( S_SGSP , 0 );
MotorPos = MotorReadPos( S_SGSP );

Position_Info.Origin_CyclePostion = MotorPos;
Position_Info.Origin_Angle = 0; 

Position_Info.Current_CyclePostion = MotorPos;
Position_Info.Current_Angle = 0; 

Position_Info.CycleFlag = 0;

% ��ʼ������ϵ
handles.hPlot = [];
handles.Plot_Scale = 10;
axis( handles.PlotAxes , [0 handles.Plot_Scale 0 5 ]);  
handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];

set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));

set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
%*****************************************************************************


% % Basic Variables ^_^��������Ǯ�ķ�ֵ
% SearchAngle = [ 5 3 2 1 0.5 0.3 0.2 0.1 0.05 0.03 0.01 ];
% Angle_Scale_Ind = 1;
% 
% % ��ʼ������������
% % 1> ��ȡ��ǰPhoto_Sensor�ĵ�ѹ��Ϣ����¼��ind==2λ�ô� Sensor_V=[ ������� �м���� ������� ��ʱ���㻺���� ]
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,2 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% % 2> ת̨������ת2.5�ȣ���¼��ѹֵV��Sensor_V ind==3λ�ô�
% SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,3 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% % 3> ת̨��Ե�ǰλ�÷�����ת5�ȣ�����¼��ѹֵV��ind==1λ�ô�
% SetRotateUnit( S_SGSP , -SearchAngle( Angle_Scale_Ind ) );
% for i=1:3
%     fwrite( S_Sensor , 0 , 'int8' );
%     Sensor_V( 1, 2*(i-1)+4 : 2*(i-1)+4+1 ) = fread( S_Sensor , 2 );
%     Sensor_V( 1, 2*(i-1)+4 ) = Sensor_V( 1, 2*(i-1)+4 )*256 + Sensor_V( 1, 2*(i-1)+4+1);
% end
% Sensor_V( 1,1 ) = mean( Sensor_V(1,[ 3+(1:2:(2*i-1)) ]) );Sensor_V(1,4:9) = 0;
% SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %ת̨����λ
% % 4> �ж�V0��V1��V_1�Ĺ�ϵ
% while (Sensor_V(1,2)-Sensor_V(1,3))<0 || (Sensor_V(1,2)-Sensor_V(1,1))<0 || Angle_Scacle_Ind<length( SearchAngle ) 
%     if (Sensor_V(1,2)-Sensor_V(1,3))<0
%         SetRotateUnit( S_SGSP , rand(1)*SearchAngle( Angle_Scale_Ind )/2 );
%         % �����е�������������������������ظ���λ
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
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %ת̨����λ
%         
%     elseif (Sensor_V(1,2)-Sensor_V(1,1))<0
%         SetRotateUnit( S_SGSP , -rand(1)*SearchAngle( Angle_Scale_Ind )/2 );
%         % �����е�������������������������ظ���λ
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
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %ת̨����λ
%         
%     elseif (Sensor_V(1,2)-Sensor_V(1,3))>=0 && (Sensor_V(1,2)-Sensor_V(1,1))>=0
%         if Angle_Scale_Ind < length( SearchAngle )   % ��С�Ƕ�������Χ
%             Angle_Scale_Ind = Angle_Scale_Ind + 1;
%         end
%         
%         if (Sensor_V(1,3)-Sensor_V(1,1))>0
%             SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 );
%         elseif (Sensor_V(1,3)-Sensor_V(1,1))<0
%             SetRotateUnit( S_SGSP , SearchAngle( -Angle_Scale_Ind )/2 );
%         end
%         % �����е�������������������������ظ���λ
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
%         SetRotateUnit( S_SGSP , SearchAngle( Angle_Scale_Ind )/2 ); %ת̨����λ
%     end
% end
% 
% MotorPos = MotorReadPos( S_SGSP );
% % Position_Info �����ת̨ԭ��ԭʼ����  ת̨ԭʼ�Ƕ� ת̨��ǰԭʼ���� ת̨��ǰ�Ƕ�����  �������ڱ�־
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
    msgbox('����ȷ��ת̨�봫�����������Ӻã�', '�趨�Ƕȷֱ���');
else
   EditAngleResolution_Status = get(handles.EditAngleResolution , 'Enable');
   if strcmp(EditAngleResolution_Status , 'off')
      set( handles.EditAngleResolution , 'Enable', 'on');
   else
      set( handles.EditAngleResolution , 'Enable', 'off');
      EditAngleResolution = str2num( get( handles.EditAngleResolution , 'String' ) );
      if rem( EditAngleResolution ,0.005) ~= 0
         msgbox('������һ��0.005���������ķֱ���','�趨�Ƕȷֱ���');
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

set( handles.PerformMea , 'UserData' , 1 );  % 1����ִ�в�����0����ֹͣ���������㽫��ֹͣ������ִ��

% ��ô��ڶ���
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );
if S_SGSP.BytesAvailable
    fread( S_SGSP , S_SGSP.BytesAvailable );%������������
end
if S_Sensor.BytesAvailable
    fread( S_Sensor , S_Sensor.BytesAvailable );%������������
end

% ���λ����Ϣ
Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
% ��ȡ������ѹ��Ϣ
if isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    Voltage_History = [];
    set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History );
end


% ��ò����Ĳ���
Start_Angle = str2num( get( handles.EditMeaStartAngle , 'String') );
Final_Angle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );

Mea_Step_Angle = 1 ;

while( get( handles.PerformMea , 'UserData' ) )
    if Start_Angle < Final_Angle
        % ��������
        % 1> ����1��
        Dat = RotateAndRecord( S_SGSP , handles.Rotate_Scan_Rate , S_Sensor );
        % 1.1> ���һ����������ݽ��д���һ��ת�ɵ�ѹֵ
        Total_Num = length( Dat )/2;
        i=1:1:Total_Num;
        Voltage_Part( 1,i ) = (Dat( 1,2*i-1 )*256 + Dat( 1,2*i ))/1023*5;
        % 1.2> ��ӵ�����ĵ�ѹֵ��
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
           
        Voltage_History.Volt( 1 , (length( Voltage_History.Volt )+1):(length( Voltage_History.Volt )+Total_Num) ) = Voltage_Part;
        Voltage_Part_Time = (length( Voltage_History.Time )+1) : (length( Voltage_History.Time )+Total_Num);
        Voltage_Part_Time = Voltage_Part_Time*handles.Sample_Rate;
        Voltage_History.Time( 1 , (length( Voltage_History.Time )+1):(length( Voltage_History.Time )+Total_Num) ) = Voltage_Part_Time;
        % 1.3> ����������ϵ�� 
        if (~isempty( Voltage_History ) ) && ( isempty( handles.hPlot ) )
            handles.hPlot = plot(handles.PlotAxes,Voltage_History.Time , Voltage_History.Volt );
        end
        % 1.3.1 > ���ʱ�䳤��û�г�����ǰʱ��ķ�Χ������Ҫ���£���������˲���Ҫ����Moving_X_Axis 
        if length( Voltage_History.Time ) > handles.Moving_X_Axis/handles.Sample_Rate
            handles.Moving_X_Axis( 1 , 1:2 ) = handles.Moving_X_Axis( 1 , 1:2 ) + length( Voltage_Part )*handles.Sample_Rate;
        end
        set( handles.hPlot,'XData',Voltage_History.Time,'YData',Voltage_History.Volt );
        axis( handles.PlotAxes, handles.Moving_X_Axis );    
        Voltage_Part = [];  % ����Ҫ��Voltage_Part ��գ���ֹ��������ĳ���Ӱ��Voltage_History �ĸ���
        set( handles.ShowCurrentVoltage , 'UserData',Voltage_History);
        
        
        New_Pos_Info = PosInvTranslation( Mea_Step_Angle ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if New_Pos_Info.Current_CyclePostion ~= MotorPos;
            SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
        end
        % 2> ����λ����Ϣ
        Position_Info = New_Pos_Info;
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str(Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));

        % 3> �ж��Ƿ񵽴����ֵ���ָ���ʼ��
        if Position_Info.Current_Angle >= Final_Angle
            for i=1:1:(Final_Angle-Start_Angle)
                SetRotateUnit( S_SGSP , -1 );
            end
            New_Pos_Info = PosInvTranslation( -(Final_Angle-Start_Angle) ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
            % 2> ����λ����Ϣ
            Position_Info = New_Pos_Info;

            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        
        end    
    elseif Start_Angle > Final_Angle
        % �������
        % 1> ����1��
        Dat = RotateAndRecord( S_SGSP , -handles.Rotate_Scan_Rate , S_Sensor );
        % 1.1> ���һ����������ݽ��д���һ��ת�ɵ�ѹֵ
        Total_Num = length( Dat )/2;
        i=1:1:Total_Num;
        Voltage_Part( 1,i ) = (Dat( 1,2*i-1 )*256 + Dat( 1,2*i ))/1023*5;
        % 1.2> ��ӵ�����ĵ�ѹֵ��
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');    

        Voltage_History.Volt( 1 , (length( Voltage_History.Volt )+1):(length( Voltage_History.Volt )+Total_Num) ) = Voltage_Part;
        Voltage_Part_Time = (length( Voltage_History.Time )+1) : (length( Voltage_History.Time )+Total_Num);
        Voltage_Part_Time = Voltage_Part_Time*handles.Sample_Rate;
        Voltage_History.Time( 1 , (length( Voltage_History.Time )+1):(length( Voltage_History.Time )+Total_Num) ) = Voltage_Part_Time;
        % 1.3> ����������ϵ��
        if (~isempty( Voltage_History ) ) && ( isempty( handles.hPlot ) )
            handles.hPlot = plot(handles.PlotAxes,Voltage_History.Time , Voltage_History.Volt );
        end
        
        % 1.3.1 > ���ʱ�䳤��û�г�����ǰ��ʵ�ķ�Χ������Ҫ���£���������˲���Ҫ����Moving_X_Axis 
        if length( Voltage_History.Time ) > handles.Moving_X_Axis/handles.Sample_Rate
            handles.Moving_X_Axis( 1 , 1:2 ) = handles.Moving_X_Axis( 1 , 1:2 ) + length( Voltage_Part )*handles.Sample_Rate;
        end
        set( handles.hPlot,'XData',Voltage_History.Time,'YData',Voltage_History.Volt );
        axis( handles.PlotAxes,handles.Moving_X_Axis );  
        
        Voltage_Part = [];  % ����Ҫ��Voltage_Part ��գ���ֹ��������ĳ���Ӱ��Voltage_History �ĸ���
        set( handles.ShowCurrentVoltage , 'UserData',Voltage_History);
        
        New_Pos_Info = PosInvTranslation( -Mea_Step_Angle ,Position_Info );
        MotorPos = MotorReadPos( S_SGSP );
        if New_Pos_Info.Current_CyclePostion ~= MotorPos;
            SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
        end
        % 2> ����λ����Ϣ
        Position_Info = New_Pos_Info;
        set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
        set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
        set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
        % 3> �ж��Ƿ񵽴����ֵ���ָ���ʼ��
        if Position_Info.Current_Angle <= Final_Angle
            for i=1:1:(Start_Angle-Final_Angle)
                SetRotateUnit( S_SGSP , 1 );
            end
            New_Pos_Info = PosInvTranslation( -(Final_Angle-Start_Angle) ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
            % 2> ����λ����Ϣ
            Position_Info = New_Pos_Info.Current_CyclePostion;
            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));        
        end
    end
end

if S_SGSP.BytesAvailable
    fread( S_SGSP , S_SGSP.BytesAvailable );%������������
end
if S_Sensor.BytesAvailable
    fread( S_Sensor , S_Sensor.BytesAvailable );%������������
end

guidata(hObject,handles);

function Timer_Callback( hObject , eventdata , handles ) 
% ��ô��ڶ���
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles. SerialConnectSensor , 'UserData' );
% ���λ����Ϣ
Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );

guidata(hObject,handles);



% --- Executes on button press in MeaPause.
function MeaPause_Callback(hObject, eventdata, handles)
% hObject    handle to MeaPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.PerformMea , 'UserData' , 0 );  % 1����ִ�в�����0����ֹͣ���������㽫��ֹͣ������ִ��

% --- Executes on button press in SetMeaStartAngle.
function SetMeaStartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to SetMeaStartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData');
S_Sensor = get( handles.SerialConnectSensor , 'UserData');

% ȷ�ϴ��ڶ����Ѿ�����
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('����ȷ��ת̨�봫�����������Ӻã�', '�Զ�����ʼ��');
else
    % ֻҪ�����˸����ã���֮ǰ�����ݾ�Ҫ��Ĩ��
    Voltage_History.Volt=[];Voltage_History.Time=[]; 
    handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];
    set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History ); % �����������������ò������ã�������Ҫ��֮ǰ��Voltage_History ����
   
   EditMeaStartAngle_Status = get(handles.EditMeaStartAngle , 'Enable');
   if strcmp(EditMeaStartAngle_Status , 'off')
      set( handles.EditMeaStartAngle , 'Enable', 'on');
   else
      set( handles.EditMeaStartAngle , 'Enable', 'off');
      EditMeaStartAngle = str2num( get( handles.EditMeaStartAngle , 'String' ) );
      if rem( EditMeaStartAngle ,1) ~= 0
         msgbox('������һ�������ĽǶ�ֵ','�趨��ʼ��');
         set( handles.EditMeaStartAngle , 'Enable', 'on');
      else      
      % ��ת���ýǶ�
      Angle_To_Rotate = EditMeaStartAngle - Position_Info.Current_Angle;
        if Angle_To_Rotate >= 0
            % ��תָ���ĽǶ� 
            for i=1:1:Angle_To_Rotate
               SetRotateUnit( S_SGSP , 1 );
            end
            % ��ת�󣬼�¼��ǰ��ת�ĽǶȵ�ֵ����ԭʼλ��ֵ��CycleFlagֵ�����ʵ�����
            New_Pos_Info = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
                
        elseif Angle_To_Rotate < 0
            % ��תָ���ĽǶ�
            for i=1:1:abs(Angle_To_Rotate)
                SetRotateUnit( S_SGSP , -1 );
            end
            New_Pos_Info = PosInvTranslation( Angle_To_Rotate ,Position_Info );
            MotorPos = MotorReadPos( S_SGSP );
            if New_Pos_Info ~= MotorPos;
                SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
            end
        end
        % ��ת��ɺ� RawPosition �� CycleFlagsд��Position_Info�ṹ����
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

% ȷ�ϴ��ڶ����Ѿ�����
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('����ȷ��ת̨�봫�����������Ӻã�', '������ֹ��');
else
   % Ĩ��֮ǰ������ 
   Voltage_History.Volt=[];Voltage_History.Time=[]; 
   set( handles.ShowCurrentVoltage , 'UserData' , Voltage_History ); % �����������������ò������ã�������Ҫ��֮ǰ��Voltage_History ����
   handles.Moving_X_Axis = [ 0 handles.Plot_Scale 0 5  ];
   
   EditMeaFinalAngle_Status = get(handles.EditMeaFinalAngle , 'Enable');
   if strcmp(EditMeaFinalAngle_Status , 'off')
      set( handles.EditMeaFinalAngle , 'Enable', 'on');
   else
      set( handles.EditMeaFinalAngle , 'Enable', 'off');
      EditMeaFinalAngle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );
      if rem( EditMeaFinalAngle ,1) ~= 0
         msgbox('������һ�������ĽǶ�ֵ','������ֹ��');
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
%if isempty( get( handles.SerialConnectSGSP , 'UserData' ) )  % �ж�UserData�Ƿ�Ϊ�գ��յĻ��������ǿ���˵���Ѿ����Ӻã�����������
    S_Objs = get( handles.pushbuttonSerialDetect , 'UserData' );
    for i=1:length( S_Objs )
        if S_Objs(1,i).BytesAvailable ~= 0   %������������
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );
        end
        fwrite( S_Objs(1,i) , 1 ,'int8' );
        fwrite( S_Objs(1,i) , 1 ,'int8' );
        fwrite( S_Objs(1,i) , 1 ,'int8' );
        fwrite( S_Objs(1,i) , 1 ,'int8' );
        pause(0.2) % ת̨��Ӧ��Ҫʱ��
        if S_Objs(1,i).BytesAvailable == ( 33+4 )
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%������������
            set( handles.SerialConnectSGSP , 'UserData' , S_Objs(1,i) );
            set( handles.SerialConnectSGSP , 'Enable','off' );
            handles.Rotate_Scan_Rate = 6400;
            msgbox('�Զ�ת̨����������','�Զ�ת̨����');  
            
            % ��������ת̨�ʹ�����������OK����ôEnable���ÿؼ�
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % ��������Ŀؼ�ȫ��Enable
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
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%������������
        end
    end
%else
%    msgbox('�Զ�ת̨���������ӣ��벻Ҫ�ظ�����','�Զ�ת̨����');  
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
        if S_Objs(1,i).BytesAvailable ~= 0      %������������
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );
        end
        fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
        fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
        fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
        fwrite( S_Objs(1,i) , 1 ,'int8' );pause(0.1);
        pause(0.1) % ����arduino���ӷ�Ӧ�Ͽ죬�����������ʱ���Բ���
        if S_Objs(1,i).BytesAvailable == ( 4*2 )
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%������������ 
            msgbox('����������������','����������');
            set( handles.SerialConnectSensor , 'Enable','off' );
            fclose( S_Objs( 1,i ) );
            S_Objs(1,i).InputBufferSize = 10240;        % �����뻺�����Ĵ�С������10240 bytes �Է����������
            % Ĭ�ϵĴ������Ĳ������� 
            handles.Sample_Rate = 0.01;
            fopen( S_Objs( 1,i ) );
            set( handles.SerialConnectSensor , 'UserData' , S_Objs(1,i) );
            % ��ʼ�趨��ʱ��
            % Set_Rotate_Time_Max = 0.13; 
%             Sensor_Time_Max = 0.05;
%             handles.Timer=timer('Period',Sensor_Time_Max,'ExecutionMode','fixedRate', 'TimerFcn',{@Timer_Callback,handles});
            % ��������ת̨�ʹ�����������OK����ôEnable���ÿؼ�
            if ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) ) && ~isempty( get( handles.SerialConnectSGSP , 'UserData' ) )
                    % ��������Ŀؼ�ȫ��Enable
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
            fread( S_Objs(1,i) , S_Objs(1,i).BytesAvailable );%������������
        end
    end
guidata( hObject , handles );
%else
%    msgbox('���������������ӣ��벻Ҫ�ظ�����','����������');
%end

% --- Executes on button press in pushbuttonSerialDetect.
function pushbuttonSerialDetect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSerialDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ���֮ǰû�м�������ôUserDataӦ��Ϊ�գ�����Ҫ�����
if isempty( get( handles.pushbuttonSerialDetect,'UserData' ))
    S_Info = instrhwinfo('serial');
    if isempty( S_Info.SerialPorts )
         msgbox('û�м�⵽����!','���ڼ��', 'error');
    elseif length( S_Info.SerialPorts )<=1
        msgbox( '������Ŀ���ԣ�����Ƿ�������û������','���ڼ��','error' );
    else
        S_Ports = S_Info.SerialPorts;
        for i=1:length( S_Ports )
            S_Objs(1,i) = serial( S_Ports{i,1} , 'BaudRate' , 57600 );
            fopen( S_Objs(1,i) );
        end
        set( handles.pushbuttonSerialDetect , 'UserData',S_Objs );
        msgbox('�����Ѿ���','���ڼ��');
        set( handles.SerialConnectSensor , 'Enable','on' );
        set( handles.SerialConnectSGSP , 'Enable','on' );        
        
        % ��������Ŀؼ�ȫ��Disable
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
         msgbox('û�м�⵽����!','���ڼ��', 'error');
    elseif length( S_Info.SerialPorts )<=1
        msgbox( '������Ŀ���ԣ�����Ƿ�������û������','���ڼ��','error' );
    else
        S_Ports = S_Info.SerialPorts;
        for i=1:length( S_Ports )
            S_Objs(1,i) = serial( S_Ports{i,1} , 'BaudRate' , 57600 );
            fopen( S_Objs(1,i) );
        end
        set( handles.pushbuttonSerialDetect , 'UserData',S_Objs );   % ���ڳ�����ʢ���ڴ�Userdata�����ں����ѵõ��Ķ�Ӧ�Ĵ��ڶ�����ɸ�ÿ�������Ĵ������ӿؼ��ĵ�UserData
        msgbox('�����Ѿ���','���ڼ��');
        set( handles.SerialConnectSensor , 'Enable','on' );   
        set( handles.SerialConnectSGSP , 'Enable','on' );
        
        % ��������Ŀؼ�ȫ��Disable
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

set( handles.PerformMea , 'UserData' , 0 );  % 1����ִ�в�����0����ֹͣ���������㽫��ֹͣ������ִ��

Position_Info = get( handles.pushbuttonOriginCheck , 'UserData' );
S_SGSP = get( handles.SerialConnectSGSP , 'UserData' );
S_Sensor = get( handles.SerialConnectSensor , 'UserData' );

if S_SGSP.BytesAvailable
            fread( S_SGSP , S_SGSP.BytesAvailable );%������������
end
if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%������������
end

% ��ò����Ĳ���
Start_Angle = str2num( get( handles.EditMeaStartAngle , 'String') );
Final_Angle = str2num( get( handles.EditMeaFinalAngle , 'String' ) );

% 
Roll_Back_Angle = 1 ;

% �Ƿ�Ҫ�������������---------------------------?
if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    button=questdlg('�Ƿ�Ҫ��������','ȷ��','��','��','��');
    if strcmp(button,'��')
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
        [ name , path ] = uiputfile();
        save( [ path ,name ] , 'Voltage_History' );
    end
end
SetRotateUnit( S_SGSP , -Roll_Back_Angle);
% 
% % ����ת���ı�־
% if Position_Info.Current_Angle - Start_Angle ~= 0
%     if Position_Info.Current_Angle - Start_Angle > 0
%         % �ع�ԭλ��
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
% 2> ����λ����Ϣ
  
guidata( hObject , handles );

% --- Executes on button press in pushbuttonClose.
function pushbuttonClose_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('�Ƿ�ȷ�Ϲر�','�ر�ȷ��','��','��','��');
if strcmp(button,'��')
    % �Ƿ�Ҫ�������������---------------------------?
    if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
        button=questdlg('�Ƿ�Ҫ��������','ȷ��','��','��','��');
        if strcmp(button,'��')
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
            fread( S_SGSP , S_SGSP.BytesAvailable );%������������
end
if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%������������
end

% ȷ�ϴ��ڶ����Ѿ�����
if isempty(get( handles.SerialConnectSGSP , 'UserData')) &&  isempty(get( handles.SerialConnectSensor , 'UserData' ))
    msgbox('����ȷ��ת̨�봫�����������Ӻã�', '�Զ�����ת��');
else
     EditAnyRotateAngle_Status = get( handles.EditAnyRoateAngle , 'Enable' );
     if strcmp(EditAnyRotateAngle_Status , 'off')
         set( handles.EditAnyRoateAngle , 'Enable', 'on');
     else
         set( handles.EditAnyRoateAngle , 'Enable', 'off');
         Rotate_Angle =str2num( get( handles.EditAnyRoateAngle , 'String') );
         if rem( Rotate_Angle ,1) ~= 0
             msgbox('������һ�������ĽǶ�ֵ','�Զ�����ת��');
             set( handles.EditAnyRoateAngle , 'Enable', 'on');
         else 
             if Rotate_Angle >= 0
                % ��תָ���ĽǶ� 
                for i=1:1:Rotate_Angle
                    SetRotateUnit( S_SGSP , 1 );
                end
                % ��ת�󣬼�¼��ǰ��ת�ĽǶȵ�ֵ����ԭʼλ��ֵ��CycleFlagֵ�����ʵ�����
                New_Pos_Info = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                    SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
                end
                
             elseif Rotate_Angle < 0
                % ��תָ���ĽǶ�
                for i=1:1:abs(Rotate_Angle)
                    SetRotateUnit( S_SGSP , -1 );
                end
                New_Pos_Info = PosInvTranslation( Rotate_Angle ,Position_Info );
                MotorPos = MotorReadPos( S_SGSP );
                if New_Pos_Info.Current_CyclePostion ~= MotorPos;
                    SetRotateSteps( S_SGSP , New_Pos_Info.Current_CyclePostion-MotorPos );
                end
             end
             % ��ת��ɺ�Position_Info�ṹ�����ΪNew_Pos_Info
            Position_Info = New_Pos_Info;
            set( handles.pushbuttonOriginCheck , 'UserData' , Position_Info );
            set( handles.ShowCurrentAngle , 'String' , num2str( Position_Info.Current_Angle  ) );
            set( handles.ShowCurrentVoltage , 'String' , num2str( ReadVoltage( S_Sensor ) ));
            
         end
         
     end
     
     if S_SGSP.BytesAvailable
            fread( S_SGSP , S_SGSP.BytesAvailable );%������������
     end
     if S_Sensor.BytesAvailable
            fread( S_Sensor , S_Sensor.BytesAvailable );%������������
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
% �Ƿ�Ҫ�������������---------------------------?
if ~isempty( get( handles.ShowCurrentVoltage , 'UserData') )
    button=questdlg('�Ƿ�Ҫ��������','ȷ��','��','��','��');
    if strcmp(button,'��')
        Voltage_History = get( handles.ShowCurrentVoltage , 'UserData');
        [ name , path ] = uiputfile();
        save( [ path ,name ] , 'Voltage_History' );
    end
end
guidata(hObject,handles);
