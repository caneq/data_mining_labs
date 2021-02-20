function c = chi2(approx, data, theta)
c =  sum(((approx - data)./theta).^2);
end