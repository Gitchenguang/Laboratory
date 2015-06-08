function [Current_Angle Angle_Rotated ] =  PostionTranslation(  Position_Info  ) 
% [Current_Angle] =  PostionTranslation( S_Obj , Origin_Pos_Info)
% 此函数完成对转台角度的解释，将当前转台的坐标值解释为转台相对转台的坐标原点的当前坐标值
% 转台原点原始坐标+当前转台原始坐标+周期标志 ---> 当前角度值

% Edited by chenguang 2015-06-07 && Email：guang@zchenguang.com

% Position_Info 五个域：转台原点原始坐标  转台原始角度 转台当前原始坐标 转台当前角度坐标  坐标周期标志
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




