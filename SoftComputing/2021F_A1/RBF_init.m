function [T, s, w] = RBF_init(train_data, h, i, j)
%% RBF算法 初始化基函数中心、方差、隐层至输出层权值矩阵
%   #input train_data、h、i、j 训练集，各层结点数
%   #output T、s、w 基函数中心、方差、权值矩阵

    rng('default'); % 设置随机种子，使实验可复现

    % 先初始化中心，由于样本数据归一化后在[-1,1]范围内
    % 基函数中心也取[-1,1]内随机数
    T = k_means(train_data, h, i);
    % 隐层至输出层权值矩阵
    w = rand(j, i, 'double') * 2 - 1;
    
    % 最大距离平方
    dmax = d_max(T);
    % 方差
    s = dmax / (2 * i);
end

function dmax = d_max(T)
%% 求个中心之间最大距离
%   #input T 中心向量组
%   #output dmax 最大距离平方

    s = size(T);
    length = 1 : s(1);
    
    dmax = 0;
    for i = length
       for j = length
           A = T(i,:) - T(j,:);
           d = dot(A, A);
           if d > dmax
               dmax = d;
           end
       end
    end   
end


