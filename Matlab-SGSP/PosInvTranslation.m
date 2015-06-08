function [ CurrentRawPos CycleFlag ] = PosInvTranslation( RotateAngle ,Position_Info )
% 将要旋转的角度逆向转换为转台的控制器的原始位置,这里将只对应出同一周期的数值

% Edited by chenguang 2015-06-07 && Email:guang@zchenguang.com

% Position_Info 五个域：转台原点原始坐标  转台原始角度 转台当前原始坐标 转台当前角度坐标  坐标周期标志
% Position_Info.Origin_CyclePostion = MotorPos;
% Position_Info.Origin_Angle = 0; 
% Position_Info.Current_CyclePostion = MotorPos;
% Position_Info.Current_Angle 
% Position_Info.CycleFlag 

Steps = RotateAngle/0.00015625;
FinalRawPos = Steps + Position_Info.Current_CyclePostion;
CycleFlag = fix( FinalRawPos/1000000 );
if CycleFlag < 0
    CurrentRawPos = FinalRawPos - CycleFlag*1000000 + 1000000;  % 换成补码的形式
else
    CurrentRawPos = FinalRawPos - CycleFlag*1000000;
end
