function neighbors = neighbor(M,J,r)
%	寻找优胜结点J的邻居们序号
%   #input  M，J，r	总结点数，优胜结点序号，邻居范围
%   #output neighbors 邻居们及其距离
    neighbors = zeros(M, 1);    % 初始化
    for j = 1:M
        d = min(abs(j - J), M - abs(j - J));    % 与优胜结点距离
        neighbors(j) = d;            % 记录邻居和距离
    end
end

