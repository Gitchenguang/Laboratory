clear all

% 相对与multiselect0
% 该脚本把 Epa Ipa Epc Ipc 十轮的 均值 最大差值的绝对值 标准差 进行了
% 1月9日进行了修正 见第28 29行

[filename,filepath]=uigetfile('*.txt','MultiSelect','on');

filenum=length(filename);
dataset=zeros(20000,2*filenum);

%载入数据文件 
for j=1:1:filenum
    dataset( :,((j-1)*2+1):((j-1)*2+2))=load([filepath filename{1,j}]);
end

% 数据文件的cycle数目
 cyclenum=10;
 
% 设置存储结构
output=zeros(filenum,cyclenum*4);

for fileind=1:1:filenum
 
     for i=1:1:cyclenum
         datind=2000*(i-1);
         [cmax,maxind]=max(dataset(datind+501:datind+800,((fileind-1)*2+2)));
         [cmin,minind]=min(dataset(datind+1501:datind+1800,((fileind-1)*2+2)));
         output(fileind,((i-1)*4+1):((i-1)*4+2))=[dataset(datind+maxind+500,1),cmax*1000000];   % 之前这里没有加datind
         output(fileind,((i-1)*4+3):((i-1)*4+4))=[dataset(dataind+minind+1500,1),cmin*1000000]; % 同上
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