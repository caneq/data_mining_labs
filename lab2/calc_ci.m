function res = calc_ci(sigm, a, CovB, v)
diag_cov = diag(CovB);
sigm_len = length(sigm);
res = zeros(sigm_len, 2);
for k = 1:1:sigm_len
    res(k, :) = [sigm(k) + tinv(a/2,v)*sqrt(diag_cov(k)), sigm(k) + tinv(1 - a/2,v)*sqrt(diag_cov(k))];
end