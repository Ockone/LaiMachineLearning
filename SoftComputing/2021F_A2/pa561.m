
%% --------------------------HyperParameters------------------------
% 学习率
alpha = 0.1;    % G(t)函数衰减率
beta = 0.4;     % 权值修改学习率
eta = 0.5;      % 加速方法参数
% 邻居范围
percent = 0.9;  % r = M * percent;
% 最大训练轮次
epoch = 500;
G = 20;

%% ----------------------------DataLoader--------------------------
% 从文件中读入数据（主要指城市坐标数据）
T_source = readtable("data/pa561.tsp.txt");    % 读入坐标数据
%normal_T = normalize(T, 'rang', [0,1], 'DataVariables', [2,3]);  % 数据归一化
T = data_shuffle(T_source);
city = table2array(T(:, 2:3));
tour = load("data/pa561.tour.txt"); % 读入参考路径规划

%% ------------------------------初始化----------------------------
% 初始化结点是一个TOP次序的圆环
s = size(city, 1);          % 获取城市个数，也即SOM结点数
M = 3 * s;                  % SOM结点数
r = round(M * percent); 
angle = 0:2*pi/(M-1):2*pi;      % 创建M个角度
x = cos(angle);             % 横坐标
y = sin(angle);             % 纵坐标
W = [x', y'];               % 组成权值矩阵
W = W * 200 + [mean(city(:,1)),mean(city(:,2))];             % 让该圆环起始位置足够小