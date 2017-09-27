clear
clc

//function y = funcao(x)
//    y=(x(1) - 2).^4 + (x(1)-2*x(2)).^2;
//endfunction

function grad_x = gradiente(x)
    n = length (x);
    h = 1e-5;
    gg = [];

    for i = 1 : n
        x_adv = x
        x_adv(i) = x(i) + h;
        dev = (f(x_adv)- f(x))/h;
        gg = [gg; dev];
        
    end

    grad_x = gg;
endfunction

function linha = derivada1(x,yj,dj)
    h = 1e-5;
    linha = (func_teta(x + h,yj,dj)- func_teta(x - h,yj,dj))/ (2*h);
endfunction

function duas_linha = derivada2 (x,yj,dj)
    h = 1e-5;
    duas_linha = (func_teta(x + h,yj,dj) - (2*func_teta(x,yj,dj)) + func_teta(x - h,yj,dj))/h.^2; 
endfunction

function valor_teta=func_teta(x,yj,dj)
    valor_teta=f(yj+x*dj);
endfunction

function lambda = newton (lambda,yj,dj)
  //lambda = 10;
tolerance = 10^-3;
    erro = 10;
    while (erro > tolerance)
        lambda_novo = lambda - (derivada1(lambda,yj,dj)/derivada2(lambda,yj,dj));
        erro = abs (lambda_novo - lambda);
        lambda = lambda_novo;   
    end
    lambda = lambda_novo;
endfunction


function otimo = steepest_descent(xk)
    erro = 1;
    tol = 1e-4;
    while erro > tol 
        dk = -gradiente (xk);   
        lambdak = newton (0.1,xk,dk);
        xk_new = xk + lambdak*dk
        erro = norm (gradiente(xk_new) - gradiente(xk));
        xk = xk_new; 
    end
    otimo = xk
endfunction
