Perform_Measure = 1;

Photo_Diode_Port = serial('COM16');
Photo_Diode_Port.BaudRate = 57600;
fopen( Photo_Diode_Port );
for i=1:1000
    fwrite( Photo_Diode_Port , Perform_Measure );
    pause(0.01)
    Dat_HL = fread( Photo_Diode_Port , 2 );
    Photo_Voltage = ( Dat_HL(1)*256+Dat_HL(2) )/1023*5;
end

fclose( Photo_Diode_Port );
delete( Photo_Diode_Port );
clear Photo_Diode_Port