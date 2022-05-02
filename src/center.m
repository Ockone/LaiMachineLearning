function [mean_face, center_data] = center(source_data)
%样本数据中心化
%   source_data     m×n矩阵    n个m维样本，因为每一列维一个样本
%   center_data     m×n矩阵   中心化后样本

    center_data = zeros(size(source_data));  % 初始化目标矩阵，与源矩阵形状相同
    mean_face = mean(source_data, 2);           % 计算源样本矩阵各维度均值，即平均脸
    for i = 1:size(source_data, 2)
        center_data(:,i) = source_data(:,i) - mean_face;    % 中心化
    end

end

