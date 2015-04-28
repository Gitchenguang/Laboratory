function [ Ioutput , Iaverage ]=SelectLastCycle( headlines , cyclenum , pointspercycle , cycletoselect )

%function [ Ioutput , Iaverage ]=SelectLastCycle( headlines , cyclenum , pointspercycle , cycletoselect )

% 2015 04 28 
% ȡָѭ���ĵ���ֵ�������ÿ�еľ�ֵ

% ���������ļ�
[filename,filepath]=uigetfile('*.txt','MultiSelect','on');
filenum=length(filename);

% �������ݴ�С
dataSize = pointspercycle*cyclenum - 1;
dataSet = zeros( dataSize , filenum );

% ȥ���ļ���ͷ��
for j=1:1:filenum
    [ a , b ]= textread([filepath filename{1,j}],'%f%f', 'delimiter',',','headerlines',headlines);
    dataSet( :,j)=b;
end

%  �������һ��ѭ��ȱ��һ�У����Խ����ж��Ƿ�Ҫѡ���һ��ѭ��
if (cyclenum == cycletoselect)
    DataToRemove = pointspercycle*( cycletoselect-1 );
    Ioutput = dataSet( (DataToRemove+1):(DataToRemove+pointspercycle -1 ) , : );
else
    DataToRemove = pointspercycle*( cycletoselect-1 );
    Ioutput = dataSet( (DataToRemove+1):(DataToRemove+pointspercycle ) , : ); 
end 

% ������ݺ������ֵ
Iaverage = mean( Ioutput , 2 );