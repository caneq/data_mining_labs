function z=my_gauss_gen(N, m, D)
z = m + randn(1,N).*sqrt(D);