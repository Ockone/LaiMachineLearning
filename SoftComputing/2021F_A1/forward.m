function a = forward(x, w, b)
%% 前向传递的矩阵运算，结果作为sigmoid的输入
%   #input x,w,b 来自上一层的向量x、权值矩阵，偏移向量
%   #output a 结果也是一个向量
    a = w * x + b;
end

