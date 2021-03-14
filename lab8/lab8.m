[Xplot,Yplot] = meshgrid(-30:0.75:30,-30:0.75:30);
surf(Xplot,Yplot, my_func(Xplot,Yplot));

%-------------- Простой стохастический поиск --------------

N=1000000;
M=2;
A = [-30 -30];
B = [30 30];

X_simple = A + (B - A).*rand(N,M); % N случ. точек в интервале A B
F_x_simple = my_func(X_simple(:,1),X_simple(:,2)); % Значения функции в этих точках
[F_min_simple, point_ind] = min(F_x_simple); % Минимальное значение

Point = X_simple(point_ind, :);

disp('Простой стохостический поиск');
disp(['Минимум в точке (', num2str(Point), ') Значение = ', num2str(F_min_simple)]);

%-------------- Иммитация отжига --------------

T = 50; % Максимальная температура
T0 = 0.00001; % Минимальная температура
Nu = 0.99; % Скорость уменьшения температуры
X0 = [0 0];
X=X0;
i=0;
while (T>T0)
    i = i + 1;
    z = randn(2,1);
    Ks = rand(2,1);
    
    is_suitable_point = true;
    for k=1:M
        Xnew(k) = X(k) + z(k)*T*((1+i/T)^(2*Ks(k)-1)-1);
        if ((A(k) > Xnew(k))||(B(k) < Xnew(k)))
            is_suitable_point = false;
        end
    end
    if (is_suitable_point == false)
        continue;
    end
    Z = my_func(X(:,1),X(:,2));
    Znew = my_func(Xnew(:,1),Xnew(:,2));
    DeltaE = Znew - Z;
    if (DeltaE<0)
        X=Xnew;
    else
        P = exp(-DeltaE/T);
        if (rand()<P)
            X = Xnew;
        else
            T=Nu*T;
        end
    end  
end

disp('Метод иммитации отжига');
disp(['Минимум в точке (', num2str(X), ') Значение = ', num2str(my_func(X(1),X(2)))]);
