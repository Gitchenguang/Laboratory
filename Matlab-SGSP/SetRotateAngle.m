function Flag = SetRotateAngle( Serial_Obj , Angle ,Unit)
% Flag = SetRotateAngle( Serial_Obj , Angle )
% Serial_Obj : 串口对象
% Angle ： 旋转角度
% Flag ： 是否成功执行
% 此函数让转台旋转特定的角度
% 用到的子函数 ： SetRotateUnit
% Edit by chenguang 2015-05-28 Email:guang@zchenguang.com


for i=1:Angle/Unit
    SetRotateUnit(Serial_Obj , Unit );
    pause(3*Unit);
end
