function c = chi2(approx, data, sigm)
c =  sum(((approx - data)./sigm).^2);
end