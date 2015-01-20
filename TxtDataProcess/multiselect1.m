function [DispOutput output ]=multiselect1( Utunca, Umax,cyclenum,headlines )

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
output=zeros(filenum,cyclenum*4);

for fileind=1:1:filenum
 
count=Umax/Step;upper=Utunca/Step;

    for i=1:1:cyclenum
        temp=dataLength*(i-1);
        [ cmax , maxind ]=max( dataSet( temp+count+1:temp+2*count-upper,(fileind-1)*2+2 ) );%�����1����Ϊ��-0.8��0.799������0.8
        [ cmin , minind ]=min( dataSet( temp+3*count+1:temp+4*count-upper,(fileind-1)*2+2 ) );
        output(fileind,((i-1)*4+1):((i-1)*4+2))=[dataSet(temp+count+maxind,1),cmax*1000000];
        output(fileind,((i-1)*4+3):((i-1)*4+4))=[dataSet(temp+3*count+minind,1),cmin*1000000];
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