function [w1,b1, w2, b2] = BP_init(h, i, j)
%% BP算法 初始化权值矩阵（随机）
%   #input h,i,j 输入层、隐藏层、输出层结点数
%   #output [w1,b1, w2, b2] 第一层权值与偏移矩阵、第二层权值与偏移矩阵

    rng('default'); % 设置随机种子，使实验可复现
    
    % 权值范围 [-1, 1]
    w1 = rand(i, h, 'double') * 2 - 1;
    b1 = rand(i, 1, 'double') * 2 - 1;
    w2 = rand(j, i, 'double') * 2 - 1;
    b2 = rand(j, 1, 'double') * 2 - 1;
end

