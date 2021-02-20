function y = my_veibull(model, x)
a = model(1);
b = model(2);
y = x.^(b-1).*a .* b .*exp(-a .* x.^b);
end