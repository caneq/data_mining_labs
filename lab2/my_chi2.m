function y = my_chi2(n, x)
y = x.^(n./2 - 1).*exp(-x./2)./ (2.^(n./2).*gamma(n./2));
end