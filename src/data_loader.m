function [img_size, data] = data_loader(path)
%从目标文件夹读入样本
%   path    文件路径
%   data    m×n矩阵   n个m维样本，每一列为一个样本

    img_list = dir(strcat(path, '\*.bmp')); % 遍历文件目录下所有bmp文件
    num = length(img_list);                 % 记录bmp文件数
    img_size = size(imread(strcat(path, '\', img_list(1).name)));   % 取一个图片样本，记录其尺寸 x，y
    data = zeros(img_size(1)*img_size(2), num);                     % 用于记录所有样本，依据图片尺寸、数目初始化
    
    for i = 1:num
        file_name = img_list(i).name;
        img = imread(strcat(path, '\', file_name)); % 读入图片
        face = double(img(:));                      % 将位图值拉长为列向量，为了精确计算，需要置为double
        data(:,i) = face;
    end
    
end

