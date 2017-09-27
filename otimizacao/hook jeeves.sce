clc
clear

//function y = f(x)
//    y = (x(1)-2)^4 + (x(1)-2*x(2))^2
//endfunction

function yy = ff(xj, lambdaj, dj)
    yy = f(xj + lambdaj * dj)
endfunction

function deriv1 = derivada1(x, lambda, dj)
    h = 1e-5
    deriv1 = (ff(x, lambda+h, dj) - ff(x, lambda-h, dj))/(2*h)
endfunction

function deriv2 = derivada2(x, lambda, dj)
    h = 1e-5
    deriv2 = (ff(x, lambda+h, dj) - (2*ff(x, lambda, dj)) + ff(x, lambda-h, dj))/(h.^2)
endfunction

function otimo = newton(xj, lambda, dj)
    erro = 1
    tol = 1e-3
    lambdaj = lambda
    while erro > tol 
        lambdaj_novo = lambdaj - (derivada1(xj, lambdaj, dj)/derivada2(xj, lambdaj, dj))
        erro = abs(lambdaj_novo - lambdaj)
        lambdaj = lambdaj_novo
    end
    otimo = lambdaj_novo
endfunction

function hj = hook_jeeves(x)
    erro = 1
    tol = 1e-5
    xj = x
    yj = xj
    j = 1
    n = length(x)
    d = eye(n,n)
    while erro > tol
        while j <= n
            dj = d(:,j)
            lambdaj = newton(yj, 0.1, dj)
            y_novo = yj + lambdaj*dj
            yj = y_novo
            j = j + 1    
        end
        x_novo = yj
        erro = norm(x_novo - xj)
        dk = x_novo - xj
        lambda = newton(x_novo, 0.1, dk)
        yj = x_novo +lambda*dk
        xj = x_novo
    end
    hj = yj
endfunction
