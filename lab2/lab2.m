fid = fopen('data6.txt','r');
A = fscanf(fid, '%g %g', [3 inf]);
fclose(fid);

x = A(1, :);
y = A(2, :);
N = length(y);
theta = A(3, :);

%вычисление коэффициентов модели
beta_model = [1,1];
veibull_model = [1,1];
chi2_model = 0.1;

[beta_model, beta_r_lift, beta_j_lift, beta_cov_lift] = nlinfit(x, y, @my_beta, beta_model);
[veibull_model, veibull_r_lift, veibull_j_lift, veibull_cov_lift] = nlinfit(x, y, @my_veibull, veibull_model);
[chi2_model, chi2_r_lift, chi2_j_lift, chi2_cov_lift] = nlinfit(x, y, @my_chi2, chi2_model);

%вычисление аппроксимированных характеристик
beta_y = my_beta(beta_model, x);
veibull_y = my_veibull(veibull_model, x);
chi2_y = my_chi2(chi2_model, x);

%критерий согласи€
chi2_v_beta = chi2(beta_y, y, theta)./(N - length(beta_model) - 1);
chi2_v_veibull = chi2(veibull_y, y, theta)./(N - length(veibull_model) - 1);
chi2_v_chi2 = chi2(chi2_y, y, theta)./(N - length(chi2_model) - 1);


disp(['chi2_v for beta    approx = ', num2str(chi2_v_beta)]);
disp(['chi2_v for veibull approx = ', num2str(chi2_v_veibull)]);
disp(['chi2_v for chi2    approx = ', num2str(chi2_v_chi2)]);

%взвешенные остатки
r_beta = (y - beta_y)./theta;
r_veibull = (y - veibull_y)./theta;
r_chi2 = (y - chi2_y)./theta;

plot(x, r_beta, x, r_veibull, x, r_chi2);
grid on;
title('¬звешенные остатки')
xlabel('x')
ylabel('R')
legend('beta', 'veibull', 'chi2');

%автокоррел€ционные функции
beta_autokorel = autokorel(r_beta, N);
veibull_autokorel = autokorel(r_veibull, N);
chi2_autokorel = autokorel(r_chi2, N);

k = 1:1:length(beta_autokorel);

figure;
plot(k,beta_autokorel, k, veibull_autokorel, k, chi2_autokorel);
grid on;
title('јвтокоррел€ционные функции')
xlabel('k')
ylabel('Ak')
legend('beta', 'veibull', 'chi2');

%график измеренной и аппроксимированной характеристик
figure;
plot(x, my_beta(beta_model, x), x, my_veibull(veibull_model, x), x, my_chi2(chi2_model, x),x, y);
grid on;
title('»змеренна€ и аппроксимированные характеристики')
xlabel('x')
ylabel('y')
legend('beta', 'veibull', 'chi2','data');

%доверительные интервалы
B = 0.68;
a = 1 - B;
ci_beta = nlparci(beta_model, beta_r_lift, 'jacobian', beta_j_lift, 'alpha', a);
ci_veibull = nlparci(veibull_model, veibull_r_lift, 'jacobian', veibull_j_lift, 'alpha', a);
ci_chi2 = nlparci(chi2_model, chi2_r_lift, 'jacobian', chi2_j_lift, 'alpha', a);

ci_beta_2 = calc_ci(beta_model, a, beta_cov_lift, N - 1);
ci_veibull_2 = calc_ci(veibull_model, a, veibull_cov_lift, N - 1);
ci_chi2_2 = calc_ci(chi2_model, a, chi2_cov_lift, N - 1);
