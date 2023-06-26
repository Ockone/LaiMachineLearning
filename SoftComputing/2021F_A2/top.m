function J = top(A,W)
%	寻找优胜结点
%   #input A,W 输入样本，权值矩阵
%   #output J 优胜结点序号

    n = size(W,1);
    Dmin = realmax('double');
    J = 0;
    for i = 1:n
        w = W(i,:);
        d = distance(A, w);
        if d < Dmin
            Dmin = d;
            J = i;
        end
    end
end

