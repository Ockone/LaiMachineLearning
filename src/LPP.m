function [ EigVec,EigVal] = LPP( data ,new_dim)
%UNTITLED 此处显示有关此函数的摘要
%Input:
    % data :the original datasets ,whose dimension is d*N.d is the number of features and N is the number of examples.
    % 矩阵data中每列是一个样本
    % new_dim:the goal lower dimension of datasets after the process of LPP 
%Output:
    % EigVec :the first new_dim EigVectors according to EigVal
    % EigVal:the first new_dim smallest EigValue.
%   此处显示详细说明



N = size(data, 2);
W=zeros(N,N);
for i = 1:N
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

