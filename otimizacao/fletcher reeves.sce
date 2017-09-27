close
clc
clear

//function ff = f(x)
  //  ff = (x(1) - 2)^4 + (x(1) - 2*x(2))^2;
//endfunction

function gg = gradiente(x)
    h = 1e-5;
    nn = length(x);
    gg = [];
    xbase = x;
    xadv = xbase;
    for kk=1:nn
        xadv(kk) = xadv(kk)+h;
        d = (f(xadv)-f(xbase))/h;
        gg = [gg ; d];
        xadv(kk) = xadv(kk)-h;
    end
endfunction

function valor_teta = func_teta(var_lambda,yj,dj)
    valor_teta = f(yj + var_lambda*dj);
endfunction

function deriv1 = derivada(var_lambda,yj,dj)
    h = 1e-5;
    deriv1 = (func_teta(var_lambda+h,yj,dj) - func_teta(var_lambda-h,yj,dj))/(2*h);
endfunction

function deriv2 = derivada2(var_lambda,yj,dj);
    h = 1e-5;
    deriv2 = (func_teta(var_lambda+h,yj,dj)-2*func_teta(var_lambda,yj,dj)+func_teta(var_lambda-h,yj,dj))/(h^2);
endfunction

function valor_otimo = metnewton(estimat,yj,dj)
    tol = 1e-3;
    erro = 1;
    while erro > tol
        novo_lambda = estimat - derivada(estimat,yj,dj)/derivada2(estimat,yj,dj);
        erro = abs(novo_lambda - estimat);
        estimat = novo_lambda;
    end
    valor_otimo = estimat;
endfunction

function fr = fletcherreeves(x)
    tol = 1e-4;
    g1 = gradiente(x);
    erro = norm(g1);
    yj = x;
    dj = -g1;
    n = length(x);
    pontos = [yj];
    while erro > tol
        for j = 1 : n
            lambda_otimo = metnewton(.1, yj, dj);
            yj1 = yj + lambda_otimo*dj
        
            g2 = gradiente(yj1);
            alfa = norm(g2)^2/norm(g1)^2;
            d2 = -g2 + alfa*dj;
        end
        yj = yj1;
        g1 = gradiente(yj);
        dj = -g1;
        erro = norm(g1);
        pontos = [pontos yj];
    end
    fr = yj;
endfunction
