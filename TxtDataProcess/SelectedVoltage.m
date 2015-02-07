function output=SelectedVoltage( Uanode,Ucath, Umax,cyclenum,headlines )
% output=SelectedVoltage( Uanode,Ucath, Umax,cyclenum,headlines )
% Uanode��������ѹ ��Ucath��������ѹ��Umax������ѹ��cyclenum��ѭ������headlines��ͷ������
% 2��6���޸�
% �����multiselect0
% �ýű��� Epa Ipa Epc Ipc cyclenum�ֵ� ��ֵ ����ֵ�ľ���ֵ ��׼�� ������
% ������֮ǰ����������
% ����ʹ��һ����ѹ�ļ��㹫ʽ:
%               U0=-Umax+(n-1)*0.001 (n=1,2,3,4...,2*nmax)
%               nmax = Umax/0.001 

% 1��15���޸� ���Ӻ���txtͷ��˵���Ĺ���

% ��ȡtxt�����ļ�
[filename,filepath]=uigetfile('*.txt','MultiSelect','on');
filenum=length(filename);

% �������ݵ��ܳ���
Step=0.001;
dataLength=Umax/Step*4;
dataSize=dataLength*cyclenum;
dataSet=zeros(dataSize,2*filenum);

%���������ļ� 
for j=1:1:filenum
    [ a , b ]= textread([filepath filename{1,j}],'%f%f', 'delimiter',',','headerlines',headlines);
    dataSet( :,((j-1)*2+1):((j-1)*2+2))=[a,b];
end

% �����ļ���cycle��Ŀ
% cyclenum=10;
 
% ���ô洢�ṹ
output=zeros(filenum,cyclenum*2);

AnodeIndex=abs(Uanode)/Step;CathIndex=abs(Ucath)/Step;
count=Umax/Step;
for fileind=1:1:filenum
 
    for i=1:1:cyclenum
        temp=dataLength*(i-1);
        cmax = dataSet( temp+count+1+AnodeIndex,(fileind-1)*2+2 ) ;%�����1����Ϊ��-0.8��0.799������0.8
        cmin = dataSet( temp+3*count+1+CathIndex,(fileind-1)*2+2 ) ;
        output(fileind,((i-1)*2+1))=cmax*1000000;
        output(fileind,((i-1)*2+2))=cmin*1000000;
%        cmax=0;cmin=0;
    end 

end


clear loopind cmax cmin minind maxind i datind str filepath filename fileind filenum j disind 