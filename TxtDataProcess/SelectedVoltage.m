function output=SelectedVoltage( Uanode,Ucath, Umax,cyclenum,headlines )
% output=SelectedVoltage( Uanode,Ucath, Umax,cyclenum,headlines )
% Uanode：阳极电压 ；Ucath：阴极电压；Umax：最大电压；cyclenum：循环数；headlines：头行数；
% 2月6日修改
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
output=zeros(filenum,cyclenum*2);

AnodeIndex=abs(Uanode)/Step;CathIndex=abs(Ucath)/Step;
count=Umax/Step;
for fileind=1:1:filenum
 
    for i=1:1:cyclenum
        temp=dataLength*(i-1);
        cmax = dataSet( temp+count+1+AnodeIndex,(fileind-1)*2+2 ) ;%这里减1是因为从-0.8到0.799而不是0.8
        cmin = dataSet( temp+3*count+1+CathIndex,(fileind-1)*2+2 ) ;
        output(fileind,((i-1)*2+1))=cmax*1000000;
        output(fileind,((i-1)*2+2))=cmin*1000000;
%        cmax=0;cmin=0;
    end 

end


clear loopind cmax cmin minind maxind i datind str filepath filename fileind filenum j disind 