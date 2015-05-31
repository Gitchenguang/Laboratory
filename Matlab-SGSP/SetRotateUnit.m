function Flag = SetRotateUnit( Serial_Obj , Angle )
% Flag = SetRotateAngle( Serial_Obj , Angle )
% Flag : Flag==0 ����˳��ִ�����
% Serial_Obj : ���ڶ���
% Angle �����ת�Ƕ� 

% ���������������ת̨����ת�ǶȵĴ�С
% ���ڴ�ƽ̨�����64΢��==ƽ̨0.01��
% Edited by chenguang 2015-05-28 && Email��guang@zchenguang.com
% -------------------------------------------------------------------------

% ����Ƕ�Ϊ���΢��
Steps_Element = 64;
Angle_Element = 0.01;
Steps = Angle/Angle_Element*Steps_Element;

% Constants and varibles might be used 
Flag = 1; 
Dev_ACK = hex2dec( 'D' );
Max_Steps = 32700;

% 1> Check the serial status
if Serial_Obj.Status~='open'
    error('MotorSetSteps:Serial Port is closed!');
end
if abs(Steps)>32700
    error('MotorSetSteps:Variable "Steps" is to large');
end
if Steps > 0    % ת���ɲ������ʽ
    Steps_HighBits = fix( Steps / 256 );
    Steps_LowBits = Steps - Steps_HighBits*256;
else 
    tmp = Steps + 2^16;
    Steps_HighBits = fix( Steps  / 256 );
    Steps_LowBits = tmp - Steps_HighBits*256;
end

% 2> Confirm and write the steps to write to the device
fwrite( Serial_Obj , 2 , 'int8' );
if fread( Serial_Obj , 1 ) ~= Dev_ACK
    error('MotorSetSteps:The first time handshaking failed!');
else
    fwrite( Serial_Obj , 0 , 'int8' );
    if fread(Serial_Obj , 1 ) ~= Dev_ACK
        error('MotorSetSteps:The second time handshaking failed!');
    else
        fwrite( Serial_Obj , Steps_HighBits , 'int8' );
        if fread( Serial_Obj , 1 ) ~= Dev_ACK 
            error( 'MotorSetSteps: Setting motor steps high 8bits failed!' );
        else 
            fwrite( Serial_Obj , Steps_LowBits ,'int8');
            if fread( Serial_Obj ,1 ) ~= Dev_ACK
                error( 'MotorSetSteps: Setting motor steps low 8 bits failed!' );
            else 
                Flag = 0;
            end
        end 
    end
end