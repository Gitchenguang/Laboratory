function [Current_Angle Angle_Rotated ] =  PostionTranslation(  Position_Info  ) 
% [Current_Angle] =  PostionTranslation( S_Obj , Origin_Pos_Info)
% �˺�����ɶ�ת̨�ǶȵĽ��ͣ�����ǰת̨������ֵ����Ϊת̨���ת̨������ԭ��ĵ�ǰ����ֵ
% ת̨ԭ��ԭʼ����+��ǰת̨ԭʼ����+���ڱ�־ ---> ��ǰ�Ƕ�ֵ

% Edited by chenguang 2015-06-07 && Email��guang@zchenguang.com

% Position_Info �����ת̨ԭ��ԭʼ����  ת̨ԭʼ�Ƕ� ת̨��ǰԭʼ���� ת̨��ǰ�Ƕ�����  �������ڱ�־
% Position_Info.Origin_CyclePostion = MotorPos;
% Position_Info.Origin_Angle = 0; 
% Position_Info.Current_CyclePostion = MotorPos;
% Position_Info.Current_Angle 
% Position_Info.CycleFlag 

Origin_CyclePostion = Position_Info.Origin_CyclePostion;
Origin_Angle = Position_Info.Origin_Angle;

Current_CyclePostion = Position_Info.Current_CyclePostion;

CycleFlag = Position_Info.CycleFlag;

% Judge the CycleFlag 
if CycleFlag >=0
    Steps_Took = CycleFlag*1000000 + Current_CyclePostion - Origin_CyclePostion;
elseif CycleFlag < 0 
    Steps_Took = CycleFlag*1000000 - (Current_CyclePostion - Origin_CyclePostion) ;  
end
Angle_Rotated = Steps_Took * 0.00015625;
Current_Angle = Origin_Angle + Angle_Rotated;




