%zzt bp������  http://blog.csdn.net/gongxq0124/article/details/7681000/
% ���˵�����ã� http://www.cnblogs.com/guolili/p/5522622.html

clc;clear all;

%��ȡѵ������
[f1,f2,f3,f4,class] = textread('trainData.txt' , '%f%f%f%f%f',150);

%����ֵ��һ��
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 ]')  ; %'�ž����к��л���

%�����������
s = length( class ) ;
output = zeros( s , 3  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%minmax1= minmax(input);
%����������
net = newff( minmax(input) , [10 3] , { 'logsig' 'purelin'} , 'traingdx' ) ; 
% [10 3] 10�����������һ��ڵ�����3����ڶ���ڵ�

%����ѵ������
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%��ʼѵ��
%net Ӧ����һ��ģ��
net = train( net, input , output' ) ;



%��ȡ��������
[t1, t2, t3, t4, c] = textread('testData.txt' , '%f%f%f%f%f',150);

%�������ݹ�һ��
testInput = tramnmx ( [t1,t2,t3,t4]' , minI, maxI ) ;

%����
Y = sim( net , testInput ) ;

%ͳ��ʶ����ȷ��
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [m , Index] = max( Y( : ,  i ) ) ;
    if( Index  == c(i)   ) 
        hitNum = hitNum + 1 ; 
    end
end
sprintf('ʶ������ %3.3f%%',100 * hitNum / s2 )

