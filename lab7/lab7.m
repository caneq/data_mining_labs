fid = fopen('Learning_data6.txt', 'r');
data = fscanf(fid, '%g', [8 inf]);
fclose(fid);
fid = fopen('PCA_data6.txt', 'r');
data_PCA = fscanf(fid, '%g', [2 inf]);
fclose(fid);

N = length(data);
N_attrib = length(data(:,1));

clust_number = 4;

% создание карты
net = newsom(data,[2 2]);

%ф-ция классификации векторов входа по нейронной сети 
net.trainParam.epochs = 1000; %набор параметров обучения
net = train(net, data);%обучение сети соответсвующим набором

%Классифицировать исходные объекты в кластеры с использованием разработанной нейронной сети
W = sim(net,data);
clusters_distrib = vec2ind(W);%конвертирует классифицированные объекты в индексы нейронов

clustered_data = cell(clust_number, 2); % 1 стролбец исходных признаков, 2 - pca

for i = 1:length(clusters_distrib)
    cluster_id = clusters_distrib(i);
    clustered_data{cluster_id, 1} = [clustered_data{cluster_id, 1}; data(:,i)'];
    clustered_data{cluster_id, 2} = [clustered_data{cluster_id, 2}; data_PCA(:,i)'];
end

%Центры кластеров данных
M_PCA = zeros(clust_number, 2);
M = zeros(clust_number, length(data(:,1)));

for i = 1:clust_number
    M(i,:)     = mean(clustered_data{i,1});
    M_PCA(i,:) = mean(clustered_data{i,2});
end

%Отображение центров кластеров
figure
gscatter(data_PCA(1,:),data_PCA(2,:),clusters_distrib);
hold on
plot(M_PCA(:,1),M_PCA(:,2),'*');
hold off

%График средних значений признаков объектов попавших в кластер

%subplot(m, n, p) производит разбивку графического окна на несколько 
%подокон, создавая при этом новые объекты axes; значение m указывает, 
%на сколько частей разбивается окно по горизонтали, n - по вертикали, 
%а p - номер подокна, куда будет выводиться очередной график

figure
for i=1:clust_number
    subplot(2, 2, i);
    plot(M(i, :));
    axis([1 8 1 10]); %масштаб по осям
    title(['Cluster №:',num2str(i)]);
end

% Отобразить проекции объектов на оси Z1 и Z2, включённых в каждый кластер, в командном окне Matlab
for i = 1:clust_number
    disp(clustered_data{i,2});
end
