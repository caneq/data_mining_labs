n=5;  % ���������� �����
m=10; % ���������� ��������
% ��������� ������� ������� Q �������� nxm
Q= zeros(n,m);
% � ����� ��������� ������� Q������ ����������
for k = 1:n
    for j = 1:m
        Q(k,j) = round(10*rand);
    end
end

disp(Q);

sum = 0;
for k = 1:n
    for j = 1:m
        sum = sum + Q(k,j);
    end
end
disp(sum);