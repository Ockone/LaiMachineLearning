function knn_class = KNN(train_Y, sample, k)
%KNN 此处显示有关此函数的摘要
%   此处显示详细说明

    diff = train_Y - sample;                        % 测试样本与每一个训练样本求差
    diff_norm = vecnorm(diff);                      % 计算2范数，即得到欧几里得距离数组
    [~, index] = sort(diff_norm);                   % 将距离数组降序排列，原序号返回在index中
    index = index(1:k);                             % 取前k个最近样本的索引
    
    classes = ceil(index./7);                       % 按照我们划分好的，对7取商就是它的分类
    % 这里需要仔细体会为什么是ceil（向上取整）而不是fix（向下取整）
    % fix只能做到0.55准确率，ceil却可以达到0.9左右
    
    knn_class = mode(classes);                      % 分类中样本众数即为KNN分类结果

end

