function delta = f(d, G, r)
%	计算邻居受影响程度
%   #input  d,G     距离，变化函数
%   #output delta   变更幅度
    if d < r    % 在邻居范围内
        delta = exp((-1 * d^2) / (G^2));
    else        % 不在邻居范围内
        delta = 0;
    end
end

