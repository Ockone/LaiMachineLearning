function D = distance(A,B)
%	欧几里得距离
%   #input A,B 两个向量
%   #output D 欧几里得距离

    d = A - B;
    D = sqrt(sum(d.*d));
end

