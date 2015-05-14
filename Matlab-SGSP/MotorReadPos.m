function [ Motor1_Pos , Motor2_Pos ] = MotorReadPos( Serial_Obj )
% function [ Motor1_Pos , Motor2_Pos ] = MotorReadPos( Serial_Obj )
% Motor1_Pos : ת̨1��λ����Ϣ
% Motor2_Pos : ת̨2��λ����Ϣ
% Serial_Obj �� ���ڶ���

% �ú���Ϊ��ȡ����ת̨��λ����Ϣ�ĺ���

% Edited by chenguang 2015-05-14 && Email: guang@zchenguang.com 
% -------------------------------------------------------------------------

% Constants and varibles might be used 
Dev_ACK = hex2dec( 'D' );

% Check status of serial object Serial_Obj
if Serial_Obj~='open'
    error('MotorSetSpeed:Serial Port is closed!');
end

% Get the positions
fwrite( Serial_Obj , 1 , int8 );
if fread( Serail_Obj , 1 ) ~= Dev_ACK
    error('MotorReadPos:The first time handshaking failed!');
else
    fwrite( Serial_Obj , 0 , int8 );
    if fread(Serial_Obj , 1 ) ~= Dev_ACK
        error('MotorReadPos:The second time handshaking failed!');
    else
        fwrite( Serial_Obj , 0 , int8 );
        if fread(Serial_Obj , 1 ) ~= Dev_ACK
            error('MotorReadPos:The third time handshaking failed!');
        else
            fwrite( Serial_Obj , 0 , int8 );
            if fread(Serial_Obj , 1 ) ~= Dev_ACK
                error('MotorReadPos:The fourth time handshaking failed!');
            else
                Pos_Dat = fread( Serial_Obj , 34 );
            end
        end
    end
end

% Postion 


