%% -------------------------HyperParameters-------------------------
% 网络结构固定3层，但其他超参都可以在此修改

% 与BP算法类似，可以各层自定义神经元
h = 4;
i = 4;
j = 3;
% 学习率与常数
eta = 0.85;

% 训练轮次
epoch_total = 100;

% 读入训练集与测试集，data_loader中包含‘归一化’与‘随机排列’
[train_data, test_data] = data_loader('dataset.dat');
% 训练集110，测试集40；大约 3:1

% 初始化基函数中心、方差、以及隐层至输出层权值
[T, s, w] = RBF_init(train_data, h, i, j);
train_size = 113;
test_size = 37;

%% ------------------------------TRAINING---------------------------
error = zeros(1, epoch_total);  % 记录error随训练轮次变化
for epoch = 1:epoch_total
    E = 0;  % 用于记录误差
    for index = 1:train_size
        % 取一个样本
        x = train_data(index, 2:5).'; % 蝴蝶花属性，置为列向量
        category = train_data(index, 1);  % 蝴蝶花 种类（0、1、2）

        % 数值传递过隐层
        G = zeros(i, 1);
        for k = 1:i
            g = gaussian_func(x, T(k,:), s);
            G(k) = g;
        end
        % G就是输出层的输入向量

        % 接下来就是真正的权值训练过程了
        y = w * G;

        % 依据样本期望d（根据类别构造vector），转换为相应vector
        d = zeros(3, 1);
        d(category+1) = 1;   % 期望输出设置
        % 在计算输出层误差
        e = d - y;
        E = E + sum(dot(e,e)) / j;  % 记录误差
        w = w + eta * (e * G');   
    end
    error(epoch) = E / train_size; % 记录该轮次评价误差
end
% 图表展示
ep = 1:epoch_total;
plot(ep,error);
xlabel("训练轮次");
ylabel("平均Loss");
title("Loss随训练轮次变化曲线");

%% ----------------------------TESTING------------------------------
num = 0;    % 用于计数正确判断样本数
for index = 1:test_size
    % 取一个样本
    x = train_data(index, 2:5).'; % 蝴蝶花属性，置为列向量
    category = train_data(index, 1);  % 蝴蝶花 种类（0、1、2）
    
    % 数值传递过隐层
    G = zeros(i, 1);
    for k = 1:i
        g = gaussian_func(x, T(k,:), s);
        G(k) = g;
    end
    % G就是输出层的输入向量，计算最终输出y
    y = w * G;
    [m, n] = max(y);    % 获取最大元素索引
    
    % 如果分类正确，则 num++ 计数
    if category == n-1
        num = num + 1;
    end

end
disp(num/test_size);   % 输出准确率