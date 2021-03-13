function Q = calc_Q(X, U, clust_number)
    % Сумма внутрикластерных расстояний между объектами
    
    Q = 0;
    Clusters = cell(1, clust_number);
    
    for i = 1:length(X)
        clust_id = U(i,1);
        Clusters{clust_id} = [Clusters{clust_id}; X(i, :)];
    end
    
    for i = 1:clust_number
        Q = Q + sum(pdist(Clusters{i}, 'euclidean'));
    end

end