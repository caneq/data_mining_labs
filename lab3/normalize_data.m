function X_norm = normalize_data(X)
    X_norm = X;
    n_cols = length(X(1,:));
    for j = 1:1:n_cols
        col = X(:, j);
        X_norm(:, j) = (col - mean(col))./std(col);
    end
end