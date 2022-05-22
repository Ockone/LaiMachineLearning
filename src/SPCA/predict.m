function accuracy = predict(train_data,test_data, eig_faces, k)
%依据eig_faces将数据降维，进行KNN脸部识别
%   train_data  训练集
%   test_data   测试集
%   eig_faces   特征脸，即降维矩阵，20、40、。。、80维
%   k           KNN参数
%   accuracy    脸部识别准确率

    train_Y = eig_faces' * train_data;      % 训练集投影
    test_Y = eig_faces' * test_data;        % 测试集投影

    num = size(test_Y, 2);      % 记录总测试样本数
    positive = 0;               % 用于记录识别正确的样本数
    for i = 1:num
        knn_class = KNN(train_Y, test_Y(:, i), k);         % KNN分类
        label = ceil(i/3);                                  % 同样的，测试样本序号除3可以得到它的分类标签
        % 这里需要仔细体会为什么是ceil（向上取整）而不是fix（向下取整）
        % fix只能做到0.55准确率，ceil却可以达到0.9左右
        
        if knn_class == label
            positive = positive + 1;    % 若识别正确,则计数加1
        end
    end

    % 得做一个识别的效果展示
    % 就拿最后一个样本做展示


    accuracy = positive / num;      % 返回脸部识别准确率
end

