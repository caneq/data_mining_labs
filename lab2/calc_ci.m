function res = calc_ci(theta, a, CovB, v)
diag_cov = diag(CovB);
th_len = length(theta);
res = zeros(th_len, 2);
for k = 1:1:th_len
    res(k, :) = [theta(k) + tinv(a/2,v)*sqrt(diag_cov(k)), theta(k) + tinv(1 - a/2,v)*sqrt(diag_cov(k))];
end