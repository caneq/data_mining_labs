fid = fopen('data6.txt','r');
X = fscanf(fid, '%g', [2 inf])';
fclose(fid);
N = length(X);
% 1 Ц ≈вклидово
% 3 Ц города
% 5 Ц ћинковского (p= 4)

EuclideanD = pdist(X,'euclidean');
CityblockD = pdist(X,'cityblock');
MinkowskiD = pdist(X,'minkowski', 4);

% a Ц ближнего соседа ('single')
% d Ц центроидный ('centroid')
% e Ц медианной св€зи ('median')

Links = {linkage(EuclideanD, 'single'), linkage(CityblockD, 'single'), linkage(MinkowskiD, 'single');
         linkage(EuclideanD, 'centroid'), linkage(CityblockD, 'centroid'), linkage(MinkowskiD, 'centroid');
         linkage(EuclideanD, 'median'), linkage(CityblockD, 'median'), linkage(MinkowskiD, 'median');
        };
    
    
Quality = [cophenet(Links{1,1}, EuclideanD), cophenet(Links{1,2}, CityblockD), cophenet(Links{1,3}, MinkowskiD);
           cophenet(Links{2,1}, EuclideanD), cophenet(Links{2,2}, CityblockD), cophenet(Links{2,3}, MinkowskiD);
           cophenet(Links{3,1}, EuclideanD), cophenet(Links{3,2}, CityblockD), cophenet(Links{3,3}, MinkowskiD)
           ];
 
bestLink = Links{2,3};

figure
dendrogram(bestLink, 'ColorThreshold', 1);

ClustersNumber = 4;
ClustersIds = cluster(bestLink, 'maxclust',ClustersNumber);

Clusters = cell(1, ClustersNumber);
for i = 1:N
    Clusters{ClustersIds(i)} = [Clusters{ClustersIds(i)}; X(i, :)];
end

M = zeros(ClustersNumber, 2);
V = zeros(ClustersNumber, 2);
for i = 1:ClustersNumber
    M(i, :) = mean(Clusters{i});
    V(i, :) = var(Clusters{i});
end

figure
hold on
gscatter(X(:,1),X(:,2), ClustersIds);
plot(M(:,1),M(:,2), '*');
hold off

DistCenters = pdist(M); % –ассто€ни€ между центрами
DistElements = pdist2(X, M); % –ассто€ни€ между центрами и элементами
