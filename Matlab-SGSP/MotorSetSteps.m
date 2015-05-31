function Flag = MotorSetSteps( Serial_Obj , Steps )
% Flag = MotorSetSteps( Serial_Obj , Steps , ForwardBack )
% Flag : Flag==0 程序顺利执行完成
% Serial_Obj : 串口对象
% Steps ： 微步进数 -32700~32700
% ForwardBack ： 方向标志 1正向； -1反向；

% 这个函数用来设置电机的微步进数 1微步=1/12800转
% Edited by chenguang 2015-05-14 && Email：guang@zchenguang.com
% -------------------------------------------------------------------------

% Constants and varibles might be used 
Flag = 1; 
Dev_ACK = hex2dec( 'D' );
Max_Steps = 32700;

% 1> Check the serial status
if Serial_Obj~='open'
    error('MotorSetSteps:Serial Port is closed!');
end
if abs(Steps)>32700
    error('MotorSetSteps:Variable "Steps" is to large');
end
if Steps > 0    % 转换成补码的形式
    Steps_HighBits = fix( Steps / 256 );
    Steps_LowBits = Steps - Steps_HighBits*256;
else 
    tmp = Steps + 2^16;
    Steps_HighBits = fix( Steps  / 256 );
    Steps_LowBits = tmp - Steps_HighBits*256;
end

% 2> Confirm and write the steps to write to the device
fwrite( Serial_Obj , 2 , 'int8' );
if fread( Serail_Obj , 1 ) ~= Dev_ACK
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