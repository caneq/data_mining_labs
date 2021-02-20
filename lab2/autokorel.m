function res = autokorel(r, N)
res = zeros(1,N/2);
r2_mean = mean(r.^2);
    for k = 1:N/2
        sum1 = 0;
        for i = 1:N-k+1
            sum1 = sum1 + r(i)*r(i + k - 1);
        end
        res(k) = sum1/(N-k+1)/r2_mean;
    end
end