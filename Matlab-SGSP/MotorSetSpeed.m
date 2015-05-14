function Flag = MotorSetSpeed( Serial_Obj , Speed )

% Flag = MotorSetSpeed( Serial_Obj , Speed )
% Serial_Obj : ���ڶ���
% Speed      ����ת�ٶ�
% ForwardBackward �� ��ת����1Ϊ����-1Ϊ�� 

% �������ʵ�ֶԲ��������ת�ٶȵ��趨�������������ת�ٶ��޶�Ϊ-512��511���䷶Χ�ڣ�����
% Ϊ�˷�������д�����ｫ��ת�ٶ��趨��+/-255����
% ע����Ϊ��֪��ת̨���ն����Ƹ���ʱ�ǲ����õĲ������ʽ��������ֻ���˸���λ

% Edited by chenguang 2015-05-14  &&  Emai:guang@zchenguang.com
%--------------------------------------------------------------------------------

% Constants and varibles might be used 
Flag = 1; 
Dev_ACK = hex2dec( 'D' );

% 1> Check the serial status
if Serial_Obj~='open'
    error('MotorSetSpeed:Serial Port is closed!');
end
if abs( Speed ) > 500
    error('SetMotorSpeed: Speed must be smaller than 255!')
end
if Speed > 0
    Speed_HighBits = fix( Speed / 256 );
    Speed_LowBits = Speed - Speed_HighBits*256;
else 
    tmp = Speed + 2^16;
    Speed_HighBits = fix(  Speed  / 256 );
    Speed_LowBits = tmp - Speed_HighBits*256;
end


% 2> Confirm and write the speed to write to the device
fwrite( Serial_Obj , 0 , int8 );
if fread( Serail_Obj , 1 ) ~= Dev_ACK
    error('MotorSetSpeed:The first time handshaking failed!');
else
    fwrite( Serial_Obj , 0 , int8 );
    if fread(Serial_Obj , 1 ) ~= Dev_ACK
        error('MotorSetSpeed:The second time handshaking failed!');
    else
        fwrite( Serial_Obj , Speed_HighBits , int8 );
           if fread( Serial_Obj , 1 ) ~= Dev_ACK 
               error( 'SetMotorSpeed: Setting motor speed high 8bits failed!' );
           else 
               fwrite( Serial_Obj , Speed_LowBits , int8 );
               if fread( Serial_Obj ,1 ) ~= Dev_ACK
                   error( 'SetMotorSpeed: Setting motor speed low 8 bits failed!' );
               else 
                   Flag = 0;
               end
           end 
    end
end