function W = training(city)
%% --------------------------HyperParameters------------------------
% 学习率
alpha = 0.1;    % G(t)函数衰减率
beta = 0.4;     % 权值修改学习率
eta = 0.5;      % 加速方法参数
% 邻居范围
percent = 0.9;  % r = M * percent;
% 最大训练轮次
epoch = 500;
G = 10;
%% ------------------------------初始化----------------------------
% 初始化结点是一个TOP次序的圆环
s = size(city, 1);          % 获取城市个数，也即SOM结点数
M = 3 * s;                  % SOM结点数
r = round(M * percent); 
angle = 0:2*pi/(M-1):2*pi;      % 创建M个角度
x = cos(angle);             % 横坐标
y = sin(angle);             % 纵坐标
W = [x', y'];               % 组成权值矩阵
W = W * (sum(mean(city))/5) + [mean(city(:,1)),mean(city(:,2))];             % 让该圆环起始位置足够小
Dmin = d_min(city);

%% ------------------------------训练-------------------------------
for e = 1:epoch     % 训练轮次
    decay_rate = 1 / (1 + e / (epoch / 2)); % 衰减率
    G = G * decay_rate;
    %if e
    r = round(r * decay_rate)+1;            % 邻近距离
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
end

