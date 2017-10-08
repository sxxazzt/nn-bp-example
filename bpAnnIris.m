%zzt bp神经网络  http://blog.csdn.net/gongxq0124/article/details/7681000/
% 这个说明更好， http://www.cnblogs.com/guolili/p/5522622.html
%test

clc;clear all;

%读取训练数据
[f1,f2,f3,f4,class] = textread('trainData.txt' , '%f%f%f%f%f',150);

%特征值归一化
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 ]')  ; %'号就是行和列互换

%构造输出矩阵
s = length( class ) ;
output = zeros( s , 3  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%minmax1= minmax(input);
%创建神经网络
net = newff( minmax(input) , [10 3] , { 'logsig' 'purelin'} , 'traingdx' ) ; 
% [10 3] 10代表隐含层第一层节点数，3代表第二层节点

%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%开始训练
%net 应该是一个模型
net = train( net, input , output' ) ;



%读取测试数据
[t1, t2, t3, t4, c] = textread('testData.txt' , '%f%f%f%f%f',150);

%测试数据归一化
testInput = tramnmx ( [t1,t2,t3,t4]' , minI, maxI ) ;

%仿真
Y = sim( net , testInput ) ;

%统计识别正确率
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [m , Index] = max( Y( : ,  i ) ) ;
    if( Index  == c(i)   ) 
        hitNum = hitNum + 1 ; 
    end
end
sprintf('识别率是 %3.3f%%',100 * hitNum / s2 )

