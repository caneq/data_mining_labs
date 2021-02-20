X_left=-6;
X_right=6;
N=100000;

X = my_gauss_gen(N, 0, 1);

% Инициализация гистограммы
BinNumber=40;
k=0:BinNumber;
% Вычисление границ карманов на оси X
X_bins=X_left + k*(X_right -X_left)/BinNumber;
% Вычисление гистограммы для X
N_X= histc(X,X_bins);

figure;
bar(X_bins, N_X);
title('Гистограмма для X');
xlabel('Значения X');
ylabel('Количество');
