fid = fopen('data6.txt', 'r');
X = fscanf(fid, '%g ', [2 inf])';
fclose(fid);

clust_number = 4;
eps = 1e-4;

C = X(1:clust_number, :); % начальные значение центров кластеров
U = calc_clusts(X, C); % расстояния до ближайших центров кластеров

Q = calc_Q(X, U, clust_number);
Q_prev = Q + 2*eps;

iter = 0;
while abs(Q - Q_prev) > eps
    iter = iter + 1;
    C = calc_centers(X, U, clust_number);
    U = calc_clusts(X, C);
    
    Q_prev = Q;
    Q = calc_Q(X, U, clust_number);
    
end

figure
gscatter(X(:,1), X(:,2), U(:,1))
hold on
scatter(C(:,1),C(:,2),'*')    
hold off