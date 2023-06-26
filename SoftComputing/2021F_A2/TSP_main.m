clear;
clc;
tic; % 计时器
% 不同相应文件和参数单独写了脚本，导入：
%bayg29;
att48;
%eil51;
%eil76;
%eil101;
%tsp225;
%pa561;

Dmin = d_min(city);

%% ------------------------------训练-------------------------------
for e = 1:epoch     % 训练轮次
    decay_rate = 1 / (1 + e / (epoch / 2)); % 衰减率
    G = G * (1 - alpha);
    %if e
    r = round(r * decay_rate);            % 邻近距离
    %beta = beta * decay_rate;
    for i = 1:s     % 样本序号，即遍历城市
        A = city(i,:);
        J = top(A, W); % 优胜结点序号
        
        neighbors = neighbor(M, J, r);  % 邻居及其距离
        
        % 修正各结点权值
        for j = 1 : size(neighbors)
            F = f(neighbors(j), G, r);
            w = W(j, :);
            if distance(A, w) < (eta * Dmin)
                W(j, :) = A;
            else
                W(j, :) = w + beta * F * (A - w);
            end
        end
    end
    
end


%% ---------------------------计算SOM规划路径-----------------------
ct = table2array(T);
for i = 1:s
    J = top(ct(i,2:3), W);
    ct(i, 1) = J;
end
ct = sortrows(ct, 1);
my_path = 0;    % 我得到的路径长度
for i = 1:s
    next = i + 1; % 下一个城市
    if i == s
        next = 1;
    end
    a = ct(i, 2:3);     % 当前城市坐标
    b = ct(next, 2:3);  % 下一个城市坐标
    my_path = my_path + distance(a,b);
end

time = toc; % 计时结束

% -------------------------作图-----------------------
city = table2array(T_source(:, 2:3));
% 参考路径
X = zeros(s + 1);
Y = zeros(s + 1);
given_path = 0; % 给定参考版本路径长度
for i = 1 : s
    index = tour(i);
    X(i) = city(index, 1);
    Y(i) = city(index, 2);
    % 计算路径长度
    if i < s
        next = tour(i + 1); % 下一结点
    else
        next = tour(1);
    end
    given_path = given_path + distance(city(index,:), city(next,:));
end
X(s + 1) = X(1);
Y(s + 1) = Y(1);
figure('name', '参考路径');
plot(city(:,1), city(:,2), 's');
title(['城市数', num2str(s), '   路径长度',num2str(given_path)]);
hold on;
plot(X, Y, '-r');
hold off;

% 训练得路径
figure('name', 'SOM规划路径');
plot(city(:,1), city(:,2), 's');
title(['城市数', num2str(s), '   路径长度',num2str(my_path),' 运行时间', num2str(time), '秒']);
hold on
plot(W(:,1), W(:,2), '-r');
X = [W(1,1), W(M,1)];
Y = [W(1,2), W(M,2)];
plot(W(:,1), W(:,2), '.');
plot(X, Y, '-r');
hold off;

