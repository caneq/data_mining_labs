function U = calc_clusts(X, C)
    P = pdist2(X, C, 'euclidean');
    [P2, Index] = min(P,[],2);
    U = [Index, P2];
    
end