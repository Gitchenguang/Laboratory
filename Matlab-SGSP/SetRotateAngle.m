function SRU_Time = SetRotateAngle( Serial_Obj , Angle ,Unit)
% Flag = SetRotateAngle( Serial_Obj , Angle )
% Serial_Obj : ���ڶ���
% Angle �� ��ת�Ƕ�
% Flag �� �Ƿ�ɹ�ִ��
% �˺�����ת̨��ת�ض��ĽǶ�
% �õ����Ӻ��� �� SetRotateUnit
% Edit by chenguang 2015-05-28 Email:guang@zchenguang.com


for i=1:Angle/Unit
    tic
    SetRotateUnit(Serial_Obj , Unit );
    SRU_Time(1,i) = toc;
    pause(3);
end
