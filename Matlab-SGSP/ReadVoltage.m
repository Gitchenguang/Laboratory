function Voltage = ReadVoltage( S_Obj )
% 读取光电二极管的电压值
% Edited by chenguang 2015-06-08 && Email：guang@zchenguang.com

Perform_Measure = 2;
fwrite( S_Obj , Perform_Measure );
Dat_HL = fread( S_Obj , 2 );
Voltage = ( Dat_HL(1)*256+Dat_HL(2) )/1023*5;
