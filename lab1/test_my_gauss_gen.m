X_left=-6;
X_right=6;
N=100000;

X = my_gauss_gen(N, 0, 1);

% ������������� �����������
BinNumber=40;
k=0:BinNumber;
% ���������� ������ �������� �� ��� X
X_bins=X_left + k*(X_right -X_left)/BinNumber;
% ���������� ����������� ��� X
N_X= histc(X,X_bins);

figure;
bar(X_bins, N_X);
title('����������� ��� X');
xlabel('�������� X');
ylabel('����������');
