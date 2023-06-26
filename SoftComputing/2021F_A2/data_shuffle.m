function R = data_shuffle(T)
%% 将输入的数据集乱序处理，并以原格式返回
%   #input T table
%   #output R table

   ds = arrayDatastore(T, "OutputType", "same");    % 建立数据存储
   data = shuffle(ds);                              % 将数据随机排列
   R = readall(data);
end