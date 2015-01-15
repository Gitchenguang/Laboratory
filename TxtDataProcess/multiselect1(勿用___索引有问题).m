clear all

% �����multiselect0
% �ýű��� Epa Ipa Epc Ipc ʮ�ֵ� ��ֵ ����ֵ�ľ���ֵ ��׼�� ������
% 1��9�ս��������� ����28 29��

[filename,filepath]=uigetfile('*.txt','MultiSelect','on');

filenum=length(filename);
dataset=zeros(20000,2*filenum);

%���������ļ� 
for j=1:1:filenum
    dataset( :,((j-1)*2+1):((j-1)*2+2))=load([filepath filename{1,j}]);
end

% �����ļ���cycle��Ŀ
 cyclenum=10;
 
% ���ô洢�ṹ
output=zeros(filenum,cyclenum*4);

for fileind=1:1:filenum
 
     for i=1:1:cyclenum
         datind=2000*(i-1);
         [cmax,maxind]=max(dataset(datind+501:datind+800,((fileind-1)*2+2)));
         [cmin,minind]=min(dataset(datind+1501:datind+1800,((fileind-1)*2+2)));
         output(fileind,((i-1)*4+1):((i-1)*4+2))=[dataset(datind+maxind+500,1),cmax*1000000];   % ֮ǰ����û�м�datind
         output(fileind,((i-1)*4+3):((i-1)*4+4))=[dataset(dataind+minind+1500,1),cmin*1000000]; % ͬ��
         cmax=0;cmin=0;
     end
end

% ����ͳ�� ���ÿ�еľ�ֵ���׼��
Eval=mean(output);
StdVval=std(output,1);
% ��ÿ�е�����ֵ

Diffset=output-repmat(Eval,length(output(:,1)),1);
[Diffmax Diffind]=max(abs(Diffset));

disind=1:1:3;
for j=1:1:cyclenum
    DispOutput(j,disind)=[ Eval(1,(j-1)*4+1),Diffmax(1,(j-1)*4+1),StdVval(1,(j-1)*4+1)];
    DispOutput(j,disind+4)=[ Eval(1,(j-1)*4+2),Diffmax(1,(j-1)*4+2),StdVval(1,(j-1)*4+2)];
    DispOutput(j,disind+8)=[ Eval(1,(j-1)*4+3),Diffmax(1,(j-1)*4+3),StdVval(1,(j-1)*4+3)];
    DispOutput(j,disind+12)=[ Eval(1,(j-1)*4+4),Diffmax(1,(j-1)*4+4),StdVval(1,(j-1)*4+4)];
end



clear loopind cmax cmin minind maxind i datind str filepath filename fileind filenum j disind 