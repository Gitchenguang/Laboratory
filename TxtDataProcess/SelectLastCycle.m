function [ Ioutput , Iaverage ]=SelectLastCycle( headlines , cyclenum , pointspercycle , cycletoselect )

%function [ Ioutput , Iaverage ]=SelectLastCycle( headlines , cyclenum , pointspercycle , cycletoselect )

% 2015 04 28 
% 取指循环的电流值，并求出每行的均值

% 载入数据文件
[filename,filepath]=uigetfile('*.txt','MultiSelect','on');
filenum=length(filename);

% 设置数据大小
dataSize = pointspercycle*cyclenum - 1;
dataSet = zeros( dataSize , filenum );

% 去掉文件的头部
for j=1:1:filenum
    [ a , b ]= textread([filepath filename{1,j}],'%f%f', 'delimiter',',','headerlines',headlines);
    dataSet( :,j)=b;
end

%  由于最后一个循环缺少一行，所以进行判断是否要选最后一个循环
if (cyclenum == cycletoselect)
    DataToRemove = pointspercycle*( cycletoselect-1 );
    Ioutput = dataSet( (DataToRemove+1):(DataToRemove+pointspercycle -1 ) , : );
else
    DataToRemove = pointspercycle*( cycletoselect-1 );
    Ioutput = dataSet( (DataToRemove+1):(DataToRemove+pointspercycle ) , : ); 
end 

% 获得数据后求出均值
Iaverage = mean( Ioutput , 2 );