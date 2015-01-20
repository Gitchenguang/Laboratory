function [DispOutput output ]=multiselect1( Utunca, Umax,cyclenum,headlines )

% 相对与multiselect0
% 该脚本把 Epa Ipa Epc Ipc cyclenum轮的 均值 最大差值的绝对值 标准差 进行了
% 修正了之前索引的问题
% 这里使用一个电压的计算公式:
%               U0=-Umax+(n-1)*0.001 (n=1,2,3,4...,2*nmax)
%               nmax = Umax/0.001 

% 1月15日修改 增加忽略txt头部说明的功能

% 读取txt数据文件
[filename,filepath]=uigetfile('*.txt','MultiSelect','on');
filenum=length(filename);

% 计算数据的总长度
Step=0.001;
dataLength=Umax/Step*4;
dataSize=dataLength*cyclenum;
dataSet=zeros(dataSize,2*filenum);

%载入数据文件 
for j=1:1:filenum
    [ a , b ]= textread([filepath filename{1,j}],'%f%f', 'delimiter',',','headerlines',headlines);
    dataSet( :,((j-1)*2+1):((j-1)*2+2))=[a,b];
end

% 数据文件的cycle数目
% cyclenum=10;
 
% 设置存储结构
output=zeros(filenum,cyclenum*4);

for fileind=1:1:filenum
 
count=Umax/Step;upper=Utunca/Step;

    for i=1:1:cyclenum
        temp=dataLength*(i-1);
        [ cmax , maxind ]=max( dataSet( temp+count+1:temp+2*count-upper,(fileind-1)*2+2 ) );%这里减1是因为从-0.8到0.799而不是0.8
        [ cmin , minind ]=min( dataSet( temp+3*count+1:temp+4*count-upper,(fileind-1)*2+2 ) );
        output(fileind,((i-1)*4+1):((i-1)*4+2))=[dataSet(temp+count+maxind,1),cmax*1000000];
        output(fileind,((i-1)*4+3):((i-1)*4+4))=[dataSet(temp+3*count+minind,1),cmin*1000000];
        cmax=0;cmin=0;
    end 

end

% 进行统计 求出每列的均值与标准差
Eval=mean(output);
StdVval=std(output,1);
% 求每列的最大差值

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