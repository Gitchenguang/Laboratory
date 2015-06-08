function [ MotorPos ] = MotorReadPos( Serial_Obj )
% function [ Motor1_Pos ] = MotorReadPos( Serial_Obj )
% Motor1_Pos : 转台1的位置信息
% Motor2_Pos : 转台2的位置信息
% Serial_Obj ： 串口对象

% 该函数为读取两个转台的位置信息的函数

% Edited by chenguang 2015-05-14 && Email: guang@zchenguang.com 
% -------------------------------------------------------------------------

% Constants and varibles might be used 
Dev_ACK = hex2dec( 'D' );

% Check status of serial object Serial_Obj
if Serial_Obj.Status ~='open'
    error('MotorSetSpeed:Serial Port is closed!');
end

% Get the positions
fwrite( Serial_Obj , 1 , 'int8' );
if fread( Serial_Obj , 1 ) ~= Dev_ACK
    error('MotorReadPos:The first time handshaking failed!');
else
    fwrite( Serial_Obj , 0 , 'int8' );
    if fread(Serial_Obj , 1 ) ~= Dev_ACK
        error('MotorReadPos:The second time handshaking failed!');
    else
        fwrite( Serial_Obj , 0 , 'int8' );
        if fread(Serial_Obj , 1 ) ~= Dev_ACK
            error('MotorReadPos:The third time handshaking failed!');
        else
            fwrite( Serial_Obj , 0 , 'int8' );
            if fread(Serial_Obj , 1 ) ~= Dev_ACK
                error('MotorReadPos:The fourth time handshaking failed!');
            else
                pause( 0.2 );
                Dat = fread( Serial_Obj , 33 );
            end
        end
    end
end

% Postion 
Dat = Dat';
PosData(1,1:6) = Dat(1,4:9) - 48;  %从第四位开始，总共六位数字位
i = 0:1:5;
MotorPos = sum(PosData.*(10.^(5-i) ) );

