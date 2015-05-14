function Flag = MotorSetStatus( Serial_Obj , Status)
% Status = MotorSetStatus( Serial_Obj )
% Serial_Obj : ���ڶ���
% Status �� 0���� �� 1����
% Flag : ת̨״̬�趨�ɹ���־
% �ú���Ϊ�趨ת̨��״̬�����Խ�ת̨��״̬�趨Ϊ�����������ߡ����С�״̬��

% Edited by chenguang 2015-05-14 && Email��guang@zchenguang.com
% -------------------------------------------------------------------------

% Constants and varibles might be used 
Flag = 1; 
Dev_ACK = hex2dec( 'D' );

% 1> Check the serial status
if Serial_Obj~='open'
    error('MotorSetSpeed:Serial Port is closed!');
end
if Status ~= 0 || Status ~= 1
    error( 'MotorSetStatus: Please set the status of the Motor properly!' );
end

% 2>Set the status of the motor
fwrite( Serial_Obj , 3 , int8 );
if fread( Serail_Obj , 1 ) ~= Dev_ACK
    error('MotorSetStatus::The first time handshaking failed!');
else
    if Status == 1
        fwrite( Serial_Obj , 0 , int8 );
        if fread(Serial_Obj , 1 ) ~= Dev_ACK
            error('MotorSetStatus::The second time handshaking failed!');
        else
            fwrite( Serial_Obj , 0 , int8 );
            if fread( Serial_Obj , 1 ) ~= Dev_ACK 
               error( 'MotorSetStatus:: Setting motor speed high 8bits failed!' );
            else 
               fwrite( Serial_Obj , 0 , int8 );
               if fread( Serial_Obj ,1 ) ~= Dev_ACK
                   error( 'MotorSetStatus:: Setting motor speed low 8 bits failed!' );
               else 
                   Flag = 0;
               end
            end 
        end
    else
        fwrite( Serial_Obj , 64 , int8 );
        if fread(Serial_Obj , 1 ) ~= Dev_ACK
            error('MotorSetStatus::The second time handshaking failed!');
        else
            fwrite( Serial_Obj , 0 , int8 );
            if fread( Serial_Obj , 1 ) ~= Dev_ACK 
               error( 'MotorSetStatus:: Setting motor speed high 8bits failed!' );
            else 
               fwrite( Serial_Obj , 0 , int8 );
               if fread( Serial_Obj ,1 ) ~= Dev_ACK
                   error( 'MotorSetStatus:: Setting motor speed low 8 bits failed!' );
               else 
                   Flag = 0;
               end
           end 
        end
    end
end