%% -------------------------HyperParameters-------------------------
% 网络结构固定3层，但其他超参都可以在此修改
clear;
h = 4;
i = 5;
j = 3;
% 学习率与常数
alpha = 0.1;
beta = 0.1;
gamma = 1;
% 训练轮次
epoch_total =50;

% 读入训练集与测试集，data_loader中包含‘归一化’与‘随机排列’
[train_data, test_data] = data_loader('dataset.dat');
% 训练集110，测试集40；大约 3:1
% 随机 [-1, 1] 初始化权值，设置随机种子，使实验可复现
[w1, b1, w2, b2] = BP_init(h, i, j);
train_size = 113;
test_size = 37;

%% -----------------------------TRAINING----------------------------
% batch_size = 10; PPT本意是 batch_size=1
error = zeros(1, epoch_total);  % 记录error随训练轮次变化
for epoch = 1:epoch_total   % 总的训练轮次
    E = 0;  % 用于记录误差
    for index = 1:train_size
        % 取一个样本
        a = train_data(index, 2:5).'; % 蝴蝶花属性，置为列向量
        category = train_data(index, 1);  % 蝴蝶花 种类（0、1、2）

        % 从FA层输入样本，计算FB层激活值
        z = forward(a, w1, b1); % 往前传递值
        b = arrayfun(@sigmoid_func, z);    % arrayfun将函数应用于每个数组元素
        % 特别注意：这里a，w1，b1，z，b均为 matrix或vector，下文c，d，e同理

        % 从FB层获得激活值 b ，计算FC层激活值 c
        f = forward(b, w2, b2);
        c = arrayfun(@sigmoid_func, f);

        % 依据样本期望ck（根据类别构造vector），转换为相应vector
        ck = zeros(3, 1);
        ck(category+1) = 1;   % 期望输出设置
        dis = ck - c;
        % 在计算输出层误差
        I = ones(j, 1);
        d = c .* (I - c) .* (ck - c);   % sigmoid导数×误差
        E = E + sum(dot(dis,dis)) / j;  % 记录误差
        % 反向传播，计算隐藏层FB误差
        I = ones(i, 1);
        e = b .* (I - b) .* (w2' * d);  % 向前一层传递

        % 根据计算出的两层误差，计算各权值、偏置的更新值
        delta_w2 = alpha * (d * b');    % 学习率×第二个权值矩阵梯度
        delta_w1 = beta * (e * a');    % 学习率×第二个权值矩阵梯度
        delta_b2 = alpha * d;
        delta_b1 = beta * e;
        % 更新权值、偏置
        w1 = gamma * w1 + delta_w1;
        w2 = gamma * w2 + delta_w2;
        b1 = b1 + delta_b1;
        b2 = b2 + delta_b2;   
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
    a = test_data(index, 2:5)'; % 蝴蝶花属性，置为列向量
    category = test_data(index, 1);  % 蝴蝶花 种类（0、1、2）
    
    % 输入模型，获取输出（直接从 TRAINING 拷贝下来）
    % 从FA层输入样本，计算FB层激活值
    z = forward(a, w1, b1); % 往前传递值
    b = arrayfun(@sigmoid_func, z);
    f = forward(b, w2, b2);
    c = arrayfun(@sigmoid_func, f); % 得到的输出
    [m, n] = max(c);    % 获取最大元素索引
    
    % 如果分类正确，则 num++ 计数
    if category == n-1
        num = num + 1;
    end
end


disp(num/test_size);   % 输出准确率