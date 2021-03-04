fid = fopen('data6.txt','r');
X = fscanf(fid, '%g', [8 inf])';
fclose(fid);

N = length(X);
K = length(X(1,:));

X_norm = normalize_data(X);
R = (X_norm' * X_norm)./(N - 1)

d = 0;
for i=1:1:K                           
    for j=(i+1):1:K
        d = d + R(i,j).^2;
    end
end
d = N*d;
chi2 = chi2inv(0.99999, (K*(K-1))/2);

if d > chi2
    disp('Корреляционная матрица значима, применение метода целесообразно');
else
    disp('Корреляционная матрица незначима, применение метода нецелесообразно');
end

% A - матрица правых собственных векторов
% L - диагональная матрица собственных значений 
[A, L] = eig(R);

L = flipud(fliplr(L)); % чтобы выполнялись неравенства l1 >= l2 >= l3 >= ... >= lk
A = fliplr(A); % чтобы выполнялось равенство L(i,i) = var(Z(:,i))
Z = X_norm * A;

% Сумма выборочных дисперсий исходных признаков равна сумме 
% выборочных дисперсий проекций объектов на главные компоненты
sum_var_x = sum(var(X_norm));
sum_var_z = sum(var(Z));

% Относительная доля разброса, приходящаяся на j-ую главную компоненту
relat_var = var(Z)./sum(var(Z));

% Матрица ковариаций
cov_matrix = cov(Z);

figure
scatter(Z(:,1),Z(:,2),'filled')
xlabel('z1');
ylabel('z2');

Z2 = X_norm * pca(X_norm);
