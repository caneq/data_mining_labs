% ������� ��������� ���������X
X_left=-2;
X_right=2;
% ������� ��������� ��������� Y
Y_left=-3;
Y_right=3;
% ������� ���������� ��������������� �����
N=1000;
% ����� �������
[X,Y]=my_func(X_left, X_right, Y_left, Y_right, N);
% ���������� ������� �������
plot(X,Y,'*')

% ������������� �����������
BinNumber=20;
k=0:BinNumber;
% ���������� ������ �������� �� ��� X
X_bins=X_left + k*(X_right -X_left)/BinNumber;
% ���������� ������ �������� �� ��� Y

Y_bins=Y_left + k*(Y_right -Y_left)/BinNumber;
% ���������� ����������� ��� X
N_X= histc(X,X_bins);
% ���������� ����������� ��� Y
N_Y= histc(Y,Y_bins);

figure;
bar(X_bins, N_X);
title('����������� ��� X');
xlabel('�������� X');
ylabel('����������');
figure;
bar(Y_bins, N_Y);
title('����������� ��� Y');
xlabel('�������� Y');
ylabel('����������');