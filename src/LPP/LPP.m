function [ EigVec,EigVal] = LPP( data ,new_dim)
%UNTITLED 此处显示有关此函数的摘要
    % 矩阵data中每列是一个样本
%   此处显示详细说明



N = size(data, 2);
W=zeros(N,N);
for i = 1:N
%     a = data(:,i);
%     diff = data - a;                        % 测试样本与每一个训练样本求差
%     diff_norm = vecnorm(diff);                      % 计算2范数，即得到欧几里得距离数组
%     [~, index] = sort(diff_norm);                   % 将距离数组降序排列，原序号返回在index中
%     index = index(1:3);                             % 取前k个最近样本的索引
%     for j = index
%         b=data(:,j);
%         W(i,j) = heat(a,b,100);
%     end
    for j = 1:N 
        a=data(:,i);
        b=data(:,j);
        W(i,j)=dot(a,b)/(norm(a)*norm(b));
    end
end
D=zeros(N,N);

for i = 1: N 
    D(i,i)=sum(W(i,:));
end
L=D-W;
A = data*L*data';
B = data*D*data';
B = B + (1e-7)*eye(size(B));
[eigvec,eigval]=eig(B\A);
tem_eigval=diag(eigval);
[K,index]=sort(tem_eigval);
%[~,I]    = sort(diag(V),'descend');
EigVal=tem_eigval(index(1:new_dim),:);
EigVec=eigvec(:,index(1:new_dim));


end

