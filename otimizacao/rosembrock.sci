clear 
clc 


//function y = f(x)
    //y = (x(1)-2)^4 + (x(1)-2*x(2))^2;
   // y = -12*x(2) + 4 *x(1)^2 +4*x(2)^2 - 4*x(1)*x(2);
   //y = (1-x(1))^2 + 5*(x(2)-x(1)^2)^2
//endfunction

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
//disp('',lambda)
endfunction

function otimo = rosembrock(xk)
    tol = 1e-4;
    yj = xk;
    k = 1;
    n = length (xk);
    d = eye (n,n);
    erro = 1;
    vetlambda = []
    while erro > tol 
        
    j = 1;
    while j <= n
        dj = d(:,j); 
       lambdaj = newton (0.1,yj,dj);
       vetlambda (j) = lambdaj;
       yj = yj + lambdaj*dj
       j = j+1;
    end    
    x_novo = yj; 
    erro = norm (x_novo - xk);
    for i = 1:n
        soma = 0;
        for j = i:n
            soma = soma + vetlambda(j)*d(:,j);
        end    
        aj = soma;
        if (i < 2) then
            bj = aj;
        else
            soma2 = 0;
             for j = 1:(i-1)
                soma2 = soma2 + (aj'*d(:,j))*d(:,j);
             end
            bj = aj - soma2;
        end
        d(:,i) = bj/norm(bj);
    end
    xk = x_novo;
    k = k + 1;
    end
    otimo = xk
endfunction

