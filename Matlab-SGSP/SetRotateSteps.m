function [ Flag ] = SetRotateSteps( Serial_Obj , Steps ) 
% [ Flag ] = SetRotateSteps( S_Obj , Steps ) 
% 让电机旋转一定的步进数
% Edited by chenguang 2015-06-08 && guang@zchenguang.com

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
if Steps >= 0    % 如果不为负，则只拆分就可以，否则转换成补码的形式
    Steps_HighBits = fix( Steps / 256 );
    Steps_LowBits = Steps - Steps_HighBits*256;
else 
    % 求补码
    Steps_Compl = 2^15 + Steps;  % 最高位第15位为符号位
    Steps_LowBits = abs( Steps_Compl -  fix( Steps_Compl  / 256 )*256);
    Steps_HighBits = fix( Steps_Compl  / 256 ) + 128 ;
end

% 2> Confirm and write the steps to write to the device
fwrite( Serial_Obj , 2 , 'uint8' );
if fread( Serial_Obj , 1 ) ~= Dev_ACK
    error('MotorSetSteps:The first time handshaking failed!');
else
    fwrite( Serial_Obj , 0 , 'uint8' );
    if fread(Serial_Obj , 1 ) ~= Dev_ACK
        error('MotorSetSteps:The second time handshaking failed!');
    else
        fwrite( Serial_Obj , Steps_HighBits , 'uint8' );
        if fread( Serial_Obj , 1 ) ~= Dev_ACK 
            error( 'MotorSetSteps: Setting motor steps high 8bits failed!' );
        else 
            fwrite( Serial_Obj , Steps_LowBits ,'uint8');
            if fread( Serial_Obj ,1 ) ~= Dev_ACK
                error( 'MotorSetSteps: Setting motor steps low 8 bits failed!' );
            else 
                Flag = 0;
                pause( abs(Steps)*0.0004096 );
            end
        end 
    end
end