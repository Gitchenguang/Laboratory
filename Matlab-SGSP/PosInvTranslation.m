function [ CurrentRawPos CycleFlag ] = PosInvTranslation( RotateAngle ,Position_Info )
% ��Ҫ��ת�ĽǶ�����ת��Ϊת̨�Ŀ�������ԭʼλ��,���ｫֻ��Ӧ��ͬһ���ڵ���ֵ

% Edited by chenguang 2015-06-07 && Email:guang@zchenguang.com

% Position_Info �����ת̨ԭ��ԭʼ����  ת̨ԭʼ�Ƕ� ת̨��ǰԭʼ���� ת̨��ǰ�Ƕ�����  �������ڱ�־
% Position_Info.Origin_CyclePostion = MotorPos;
% Position_Info.Origin_Angle = 0; 
% Position_Info.Current_CyclePostion = MotorPos;
% Position_Info.Current_Angle 
% Position_Info.CycleFlag 

Steps = RotateAngle/0.00015625;
FinalRawPos = Steps + Position_Info.Current_CyclePostion;
CycleFlag = fix( FinalRawPos/1000000 );
if CycleFlag < 0
    CurrentRawPos = FinalRawPos - CycleFlag*1000000 + 1000000;  % ���ɲ������ʽ
else
    CurrentRawPos = FinalRawPos - CycleFlag*1000000;
end
