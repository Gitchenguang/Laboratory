function Serial_Objs = SerialConfig()
% Serial_Objs = SerialConfig()
% �ú����Զ��������ڣ�����ת̨��������ܶ�Ӧ�Ĵ�����GUI�ж�Ӧ����
% Ŀǰ����������ֻ���������ڣ�һ��ΪSGSP��һ��Ϊ��������
% Edited by chenguang 2015-06-01 && guang@zchenguang.com

HW_Serial_Info = instrhwinfo( 'serial' );
Serial_Ports = HW_Serial_Info.SerialPorts;
Serial_ObjSet = { serial( Serial_Ports{1,1} , 'BaudRate',57600) , serial( Serial_Ports{1,2} , 'BaudRate',57600 ) };

Flag=0;
fwrite( Serial_ObjSet(1,1) , 1 , 'int8' );
if fread( Serial_ObjSet(1,1) , 1 ) == 13 
    fwrite( Serial_ObjSet(1,1) , 1 , 'int8' );
    if fread( Serial_ObjSet(1,1) , 1 ) == 13
        fwrite( Serial_ObjSet(1,1) , 1 , 'int8' );
        if fread( Serial_ObjSet(1,1) , 1 ) == 13 
            fwrite( Serial_ObjSet(1,1) , 1 , 'int8' );
             if fread( Serial_ObjSet(1,1) , 1 ) == 13
                 fread( Serial_ObjSet(1,1) , 34 );
             else
                 Flag=1;
             end
        else
            Flag=1;
        end
    else
        Flag=1;
    end
else
    Flag=1;
end

if Flag==0
    Serial_Objs = Serial_ObjSet;
else
    Serial_Objs(1,1) = Serial_ObjSet(1,2);
    Serial_Objs(1,2) = Serial_ObjSet(1,1);
end
  

