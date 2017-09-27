clear
clc

//function y = f(x)
//    y = (x(1)-2)^4 + (x(1)-2*x(2))^2
    //y = 2*x(1)+2*x(2)
//endfunction

function valor_teta = func_teta(var_lambda, yj, dj)
    valor_teta = f(yj + var_lambda*dj)
endfunction

function deriv = derivada(var_lambda, yj, dj)
    h = 1e-5;
    deriv = (func_teta(var_lambda + h, yj, dj) - func_teta(var_lambda - h, yj, dj))/(2*h);
endfunction

function deriv2 = derivada2(var_lambda, yj, dj)
    h = 1e-5;
    deriv2 = (func_teta(var_lambda + h, yj, dj) - ( 2*func_teta(var_lambda, yj, dj)) + func_teta(var_lambda - h, yj, dj))/(h.^2);
endfunction

function grad_x = gradiente(x)
    n = size(x)(1)
    grad_x = []
    h = 1e-5;
    for i = 1 : n
        xadv = x
        xadv(i) = x(i) + h
        deriv = (f(xadv) - f(x))/h
        grad_x = [grad_x;deriv]
    end
endfunction

function valor_otimo = metNewton(estimat, yj, dj)
    tol = 1e-3;
    erro = 1;
    while erro > tol
        novo_lambda = estimat - (derivada(estimat, yj, dj)/derivada2(estimat, yj, dj));
        erro = abs(novo_lambda - estimat);
        estimat = novo_lambda;
    end
    valor_otimo = estimat;
endfunction

function novox = dfp(x1)
    tol = 1e-4;
    y1 = x1;
    n = length(x);
    erro = 1;
    yj = y1;
    Dj = eye(n,n);
    while erro > tol
        j = 1;
        while j <= n
            dj = -Dj*gradiente(yj);
            lambda_otimo = metNewton(0.1, yj, dj);
            yjplus1 = yj + lambda_otimo*dj;
            pj = yjplus1 - y1; // pj = lambda_otimo * dj;
            qj = gradiente(yjplus1) - gradiente(yj);
            Djplus1 = Dj + (pj * pj')/(pj'*qj) - (Dj*qj*qj'*Dj)/(qj'*Dj*qj); //devido as operações com as matrizes, a entrada da função dfp deve ser em forma de coluna.
            j = j+1;
            yj = yjplus1;
            Dj = Djplus1;
        end
        novox = yjplus1;
        erro = norm(gradiente(novox));
        y1 = novox;
    end
endfunction
