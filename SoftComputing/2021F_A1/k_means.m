function T = k_means(train_data, h, i)
%% 根据训练集通过 k-means 方法确定 i 个中心点
%   #input train_data、i 训练集、隐层结点数
%   #output T 中心点组成的矩阵

    %rng('default'); % 设置随机种子，使实验可复现

    % 先设置初始中心
    T = train_data(1:i, 2:5);
    % 做20次迭代
    for epoch = 1:20
        s = size(train_data);
        temp_T = zeros(i, h);
        num_T = zeros(i, 1);
        for k = 1:s(1)
            x = train_data(k,2:5);
            index = c_index(x, T);
            temp_T(index,:) = temp_T(index,:) + x;
            num_T(index) = num_T(index) + 1;
        end   
        for k = 1:i
            temp_T(k,:) = temp_T(k,:) / num_T(k);
        end
        T = temp_T;
    end
end

function c = c_index(x, T)
%% 求个中心之间最大距离
%   #input T 中心向量组
%   #output dmax 最大距离平方

    s = size(T);
    
    dmin = realmax;
    c = 0;
    for i = 1 : s(1)
        t = T(i, :) - x;
        d = dot(t, t);
        if d < dmin
            dmin = d;
            c = i;
        end
    end
end