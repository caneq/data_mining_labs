fid = fopen('data6.txt', 'r');
X = fscanf(fid, '%g', [2 inf])';
fclose(fid);
N = length(X);

%figure;
%plot(X(:,1), X(:,2), '*');

neuron_number = 4;

minX = min(X);
maxX = max(X);

% алгоритм сети Кохонена
W = rand(neuron_number, 2).*(maxX - minX) + minX;
W_prev = zeros(neuron_number, 2);

k_max = 1000000;
k = 0;
h = 0.05;
while (sum(abs(W - W_prev)) > 1e-6) & (k < k_max)
    k = k + 1;
    W_prev = W;
    
    rand_observation = X(randi(N), :);
    
    P = pdist2(rand_observation, W);
    [min_dist, index] = min(P);
    W(index,:) = W(index,:) + h*(rand_observation - W(index,:));

end

% Выделение в кластеры
U = zeros(1,N);
for i = 1:N
    [val, ind] = min(pdist2(X(i,:), W));
    U(i) = ind;
end

figure
gscatter(X(:,1), X(:,2), U)
hold on
scatter(W(:,1),W(:,2),'*')    
hold off