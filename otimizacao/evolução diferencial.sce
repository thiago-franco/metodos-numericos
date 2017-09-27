clear 
clc
//function y = f(x)
//    y = (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2;
//endfunction

function mut = mutacao(x, y)
    r1 = x(:, grand(1, 'prm', (1:np)'));
    r2 = x(:, grand(1, 'prm', (1:np)'));
    r3 = x(:, grand(1, 'prm', (1:np)'));
    mut = r1 + (y*(r2-r3));
endfunction

function rec = crossover(x, v, cr)
    r = int(np*rand());
    for j = 1 : np 
        if (rand (1,1) <= cr) | (j==r) 
            u(:,j) = v(:,j);
        else 
            u(:,j) = x(:,j);
        end
    end
    rec = u
endfunction

function x = selecao(x, u)
    for i = 1 : np
        fx = f(x(:,i));
        fu = f(u(:,i));
        if(fu < fx)
            x(:,i) = u(:,i);
        end
    end
endfunction

function x = de()
    cr = 0.5;
    y = 1.2;
    d = 2;
    np = 100;
    gmax = 1000;
    lim_inf = [-5;-5];
    lim_sup = [5;5];
    for i = 1 : np
        x(:,i) = lim_inf + rand(d,1).*(lim_sup - lim_inf);
    end
    k = 0;
    while(k < gmax)
        k = k +1;
        v = mutacao(x, y);
        u = crossover(x, v, cr);
        x = selecao(x, u);
    end
endfunction
