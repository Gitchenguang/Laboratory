function Flag = SetRotateAngle( Serial_Obj , Angle ,Unit)
% Flag = SetRotateAngle( Serial_Obj , Angle )
% Serial_Obj : ���ڶ���
% Angle �� ��ת�Ƕ�
% Flag �� �Ƿ�ɹ�ִ��
% �˺�����ת̨��ת�ض��ĽǶ�
% �õ����Ӻ��� �� SetRotateUnit
% Edit by chenguang 2015-05-28 Email:guang@zchenguang.com


for i=1:Angle/Unit
    SetRotateUnit(Serial_Obj , Unit );
    pause(3*Unit);
end
