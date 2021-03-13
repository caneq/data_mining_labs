function C = calc_centers(X, U, clust_number)
    C = zeros(clust_number, length(X(1,:)));
    points_count = zeros(1, clust_number);
    for i = 1:length(X)
        cluster_id = U(i,1);
        C(cluster_id, :) = C(cluster_id, :) + X(i,:);
        points_count(cluster_id) = points_count(cluster_id) + 1;
    end
    
    for i = 1:clust_number
        C(i, :) = C(i, :) ./ points_count(i);
    end
end