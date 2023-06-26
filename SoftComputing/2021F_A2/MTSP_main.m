clear;
clc;
% 多旅行商问题，仅以101城市为例


%% ----------------------------DataLoader--------------------------
% 从文件中读入数据（主要指城市坐标数据）
T = readtable("data/eil101.tsp.txt");    % 读入坐标数据
%normal_T = normalize(T, 'rang', [0,1], 'DataVariables', [2,3]);  % 数据归一化
city = table2array(T(:, 2:3));
s = size(city, 1);
W1 = zeros(s, 2);
W2 = zeros(s, 2);
W3 = zeros(s, 2);
t1 = 0;
t2 = 0;
t3 = 0;
for i = 1:s
    A = city(i, :);
    if A(2) > 50
        t1 = t1 + 1;
        W1(t1,:) = A;
    elseif A(1) < 35
        t2 = t2 + 1;
        W2(t2,:) = A;
    else
        t3 = t3 + 1;
        W3(t3,:) = A;
    end
end

W1 = training(W1(1:t1, :));
W2 = training(W2(1:t2, :));
W3 = training(W3(1:t3, :));


%% -----------------------计算路径---------------------
% 多旅行商问题就不计算路径长度了

% -------------------------作图-----------------------
% 训练得路径作图
figure(2);
plot(city(:,1), city(:,2), 's');
hold on;
draw2D(W1, '-r');
hold off;
hold on;
draw2D(W2, '-b');
hold off;
hold on;
draw2D(W3, '-g');
hold off;

