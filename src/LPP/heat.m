function w = heat(A,B,t)
%HEAT 此处显示有关此函数的摘要
%   此处显示详细说明
dis = vecnorm(A-B);
index = -1 * dis / t;
w = exp(index);
end

