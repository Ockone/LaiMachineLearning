clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   数据读入，中心化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img_path = "C:\Users\ad\Desktop\Lai_zhihui_ML\face\ORL_56_46";

% img_size      记录图片尺寸x，y
% data      m×n      n个m维样本，m=x*y
[img_size, data] = data_loader(img_path);   % 读入样本

% 划分数据集，70%作为训练集，30%作为测试集
train_index = zeros([40 * 7, 1], 'int32');
test_index = zeros([40 * 3, 1], 'int32');
for i = 0:39
    train_index(7*i+1 : 7*i+7) =  10*i+1 : 10*i+7;
    test_index(3*i+1 : 3*i+3) =  10*i+8 : 10*i+10;
end
train_data = data(:, train_index);
test_data = data(:, test_index);

% mean_face     平均脸
% center_data   中心化后的样本矩阵
[mean_face, center_data] = center(train_data);    % 中心化

% 展示部分图片
figure('Name', '展示部分样本');
count = 1;
for i = 1:14:280                % 展示20张图片
    subplot(4, 5, count);       % 锚定位置
    fig = display_face(center_data(:,i) + mean_face, img_size);
    title(['id=', num2str(i)]);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PCA：主成分分析基本步骤
%   1、求协方差矩阵（散度矩阵）
%   2、求解特征值与特征向量（eig或svd方法）
%   3、投影
%   4、重构图片
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1、协方差矩阵
% cov_mat = center_data * center_data';   % 由于已中心化，故原矩阵协方差矩阵就这么求解
% 因为我构建的矩阵是每一列为一个样本，故计算协方差矩阵 X*X'，而不是 X'*X

% 2、求解特征值与特征向量
% 使用奇异值分解svd解特征值和特征向量，就不需要计算协方差矩阵了
[U, S, V] = svd(center_data);               % 奇异值分解
% U的列向量是协方差矩阵的特征向量
% 也即是按特征值降序排列的特征脸

% 展示一下前20个特征脸
% 展示部分图片
figure('Name', '展示前20特征脸');
count = 1;
for i = 1:20                                % 展示20张图片
    subplot(4, 5, count);                   % 锚定位置
    fig = display_face(U(:,i), img_size);   % 特征脸不要加mean_face
    title(['id=', num2str(i)]);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   基于得到的特征脸，进行人脸重构
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample_face = center_data(:, 1);        % 取一个样本，做脸部重构实验
figure('Name', '脸部重构');
subplot(3, 4, 2);
fig = display_face(sample_face + mean_face, img_size);
title('原图');
count = 5;
for i = 20:20:160
    eig_faces = U(:, 1:i);              % 取前i个特征向量
    Y = eig_faces' * sample_face;       % 投影 为i维向量
    Z = eig_faces * Y;                  % 重构为原图片尺寸
    subplot(3, 4, count);
    fig = display_face(Z + mean_face, img_size);
    title([num2str(i), '维']);
    count = count + 1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   基于降维数据，使用KNN进行人脸识别
%   1、数据预处理，降维
%   2、计算测试样本与其他先验样本距离
%   3、按距离排序选择出最近的K个样本
%   4、将测试样本归入K样本中占比最多的类别
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1、先构建训练集与测试集，脚本开头已构建完成
% 训练集280样本，测试集120样本
% 很容易得，训练样本的序号除7所得商，就是其所属类别

% 训练集、测试集样本都进行降维操作
e = eig_faces(:, 1:60);
acc = predict(train_data, test_data, e, 5);
