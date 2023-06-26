function draw2D(W,type)
    M = size(W, 1);

    plot(W(:,1), W(:,2), type);
    X = [W(1,1), W(M,1)];
    Y = [W(1,2), W(M,2)];
    plot(W(:,1), W(:,2), '.');
    plot(X, Y, type);
end

