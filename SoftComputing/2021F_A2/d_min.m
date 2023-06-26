function Dmin = d_min(city)
%   计算两城市间最短的距离，作为优化参数
%   #input city 城市坐标
%   #output Dmin 最短距离

    s = size(city, 1);
    Dmin = realmax('double');
    for i = 1:(s-1)
        for j = (i+1):s
            d = distance(city(i,:), city(j,:));
            if d < Dmin
                Dmin = d;
            end
        end
    end
end

