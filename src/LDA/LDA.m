function [ W, D] = LDA( data, label, class)
% LDA 

if nargin < 4
    d = 1;
end

cn = length(class);
dm = size(data,2);

if d >= dm
    error('Projection dimension must be smaller than origin data dimension...\n');
end

% compute total mean values of data
u = mean(data,1);
% compute mean value of each class and within-class variation
Sw = zeros(dm,dm);
Sb = zeros(dm,dm);
for ci=1:cn
    id   = find(label == class(ci));    % 类别维ci的索引
    ni   = length(id);                  % 类别为ci的样本数
    
    % mean value and variation of class ci
    ui   = mean(data(id,:),1);
    var  = data(id,:) - repmat(ui,ni,1);    % 中心化
    Sw   = Sw + var' * var;                  % within-class variation 各类协方差相加   
    Sb   = Sb + ((ui - u)' * (ui - u)) * ni;     % between-class variation 各类别间距相加
end
% LDA有多个目标函数选择，下面这种形式不可逆时需要正则项扰动
Sw = Sw + (1e-7)*eye(size(Sw)); % 用于修正Sw奇异值错误，我也不知道为什么有用。。。。

% train the projection matrix
[W,D] = eig(Sw\Sb);     % eig方法也会自动排好序了

end

