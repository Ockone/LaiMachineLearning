function g = gaussian_func(X,T, s)
%% 基函数 高斯函数
%   #input X，T，s 样本向量、基函数中心、方差
%   #output g 高斯输出

    d = X - T;  % 向量距离
    o = dot(d, d);  % 欧几里得距离平分
    temp = -1 * sum(o) / (2 * s);
    g = exp(temp);  % 高斯函数输出
end

