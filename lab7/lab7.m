fid = fopen('Learning_data6.txt', 'r');
data = fscanf(fid, '%g', [8 inf]);
fclose(fid);
fid = fopen('PCA_data6.txt', 'r');
data_PCA = fscanf(fid, '%g', [2 inf]);
fclose(fid);

N = length(data);
N_attrib = length(data(:,1));

clust_number = 4;

% �������� �����
net = newsom(data,[2 2]);

%�-��� ������������� �������� ����� �� ��������� ���� 
net.trainParam.epochs = 1000; %����� ���������� ��������
net = train(net, data);%�������� ���� �������������� �������

%���������������� �������� ������� � �������� � �������������� ������������� ��������� ����
W = sim(net,data);
clusters_distrib = vec2ind(W);%������������ ������������������ ������� � ������� ��������

clustered_data = cell(clust_number, 2); % 1 �������� �������� ���������, 2 - pca

for i = 1:length(clusters_distrib)
    cluster_id = clusters_distrib(i);
    clustered_data{cluster_id, 1} = [clustered_data{cluster_id, 1}; data(:,i)'];
    clustered_data{cluster_id, 2} = [clustered_data{cluster_id, 2}; data_PCA(:,i)'];
end

%������ ��������� ������
M_PCA = zeros(clust_number, 2);
M = zeros(clust_number, length(data(:,1)));

for i = 1:clust_number
    M(i,:)     = mean(clustered_data{i,1});
    M_PCA(i,:) = mean(clustered_data{i,2});
end

%����������� ������� ���������
figure
gscatter(data_PCA(1,:),data_PCA(2,:),clusters_distrib);
hold on
plot(M_PCA(:,1),M_PCA(:,2),'*');
hold off

%������ ������� �������� ��������� �������� �������� � �������

%subplot(m, n, p) ���������� �������� ������������ ���� �� ��������� 
%�������, �������� ��� ���� ����� ������� axes; �������� m ���������, 
%�� ������� ������ ����������� ���� �� �����������, n - �� ���������, 
%� p - ����� �������, ���� ����� ���������� ��������� ������

figure
for i=1:clust_number
    subplot(2, 2, i);
    plot(M(i, :));
    axis([1 8 1 10]); %������� �� ����
    title(['Cluster �:',num2str(i)]);
end

% ���������� �������� �������� �� ��� Z1 � Z2, ���������� � ������ �������, � ��������� ���� Matlab
for i = 1:clust_number
    disp(clustered_data{i,2});
end
