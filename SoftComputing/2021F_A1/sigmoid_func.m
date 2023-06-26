function z = sigmoid_func(a)
%% sigmoid 激活函数
%   #input a 该神经元输入值
%   #output z 神经元激活值

    z = 1.0/(1.0+exp(-a));
end

