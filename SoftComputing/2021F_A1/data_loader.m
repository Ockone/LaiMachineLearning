function [train_data, test_data] = data_loader(file)
%%  从文件中获取训练集和测试集
%   #input file 文件路径
%   #output [train_data, test_data] 训练集、测试集

    T = readtable(file);   % 从 dataset.txt 文件中读入数据集
    normal_T = normalize(T, 'rang', [-1,1],'DataVariables', [3,4,5,6]); % 归一化
    data = data_shuffle(normal_T);         % 将数据集随机排列
    
    % 将数据集分为 3:1 的两个集合
    train_data = table2array(data(1:113, 2:6));
    test_data = table2array(data(114:150, 2:6));
end

function R = data_shuffle(T)
%% 将输入的数据集乱序处理，并以原格式返回
%   #input T table
%   #output R table

   ds = arrayDatastore(T, "OutputType", "same");    % 建立数据存储
   data = shuffle(ds);                              % 将数据随机排列
   R = readall(data);
end


