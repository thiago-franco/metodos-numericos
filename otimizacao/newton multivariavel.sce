clc
clear

//function y = f(x)
//    y = (x(1)-2)^4 + (x(1)-2*x(2))^2
    //y = 2*x(1)+2*x(2)
//endfunction

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

function hess_x = hessiana(x)
    n = size(x)(1)
    hess_x = []
    h = 1e-6;
    for i = 1 : n
        xadv = x
        xadv(i) = x(i) + h
        deriv = (gradiente(xadv) - gradiente(x))/h
        hess_x = [hess_x deriv]
    end
endfunction

function nm = newton_multi(x)
    tol = 1e-5
    erro = 1
    while erro > tol
        xnovo = x - inv(hessiana(x)) * gradiente(x)
        erro = norm(xnovo - x)
        x = xnovo
    end
    nm = xnovo
endfunction
