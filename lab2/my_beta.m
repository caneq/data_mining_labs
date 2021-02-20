function y = my_beta(model, x)
a = model(1);
b = model(2);
y = x.^(a-1).*(1-x).^(b-1)./beta(a,b);
end