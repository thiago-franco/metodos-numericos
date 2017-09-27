// Aplicação do método de Runge-Kutta 3/8 na resolução de um Sistema Massa-Mola com Amortecimento

clear 
clc

function F = f1(t, y, v, m, c, k) // Derivada de y em relação a t
    F = v;
endfunction

function F = f2(t, y, v, m, c, k) // Derivada de v em relação a t
    A = c/m;
    B = k/m;
    F = -(A*v + B*y);
endfunction

function [Y, V] = rk438(t0, y0, v0, t1, deltaT, m, c, k) // RUNGE-KUTTA de 4ª Ordem 3/8 aplicado à resolução de um sistema de duas equações diferenciais
    ti = t0;
    yi = y0;
    vi = v0;
    while ti < t1
        k11 = f1(ti, yi, vi, m, c, k);
        k12 = f2(ti, yi, vi, m, c, k);
        k21 = f1(ti + (1/3)*deltaT, yi + (1/3)*k11*deltaT, vi + (1/3)*k12*deltaT, m, c, k);
        k22 = f2(ti + (1/3)*deltaT, yi + (1/3)*k11*deltaT, vi + (1/3)*k12*deltaT, m, c, k);
        k31 = f1(ti + (2/3)*deltaT, yi - (1/3)*k11*deltaT + k21*deltaT, vi - (1/3)*k12*deltaT + k22*deltaT, m, c, k);
        k32 = f2(ti + (2/3)*deltaT, yi - (1/3)*k11*deltaT + k21*deltaT, vi - (1/3)*k12*deltaT + k22*deltaT, m, c, k);
        k41 = f1(ti + deltaT, yi + k11*deltaT - k21*deltaT + k31*deltaT, vi + k12*deltaT - k22*deltaT + k32*deltaT, m, c, k);
        k42 = f2(ti + deltaT, yi + k11*deltaT - k21*deltaT + k31*deltaT, vi + k12*deltaT - k22*deltaT + k32*deltaT, m, c, k);
        yi = yi + (deltaT/8)*(k11 + 3*k21 + 3*k31 +k41);
        vi = vi + (deltaT/8)*(k12 + 3*k22 + 3*k32 +k42);
        ti = ti + deltaT;
    end
    Y = yi;
    V = vi;
endfunction

function [Y, V] = solucaoAnalitica(t, y, v, m, c, k) // Solução analítica do problema do Sistema Massa-Mola com Amortecimento
    A = c/m;
    B = k/m;
    P = -A/2; 
    Q = sqrt(B-(A^2)/4);
    Y = y*exp(P*t)*(cos(Q*t)-(P/Q)*sin(Q*t));
    V = -y*exp(P*t)*((P^2+Q^2)/Q)*sin(Q*t);
endfunction

function imprimir(c, k, ye, yn, ve, vn)
    disp("k = ");
    disp(k);
    disp("y(t)exato = ");
    disp(ye);
    disp("y(t)numerico = ");
    disp(yn);
    disp("v(t)exato = ");
    disp(ve);
    disp("v(t)numerico = ");
    disp(vn);
endfunction

function main() // Solução do problema de um Sistema Massa-Mola com Amortecimento para os parâmetros m, c e k dados 
    t0 = 0;
    y0 = 0.5;
    v0 = 0;
    deltaT = 0.001;
    m = 2;
    // Para c = 0 e k = {0.25, 0.5, 0.75, 1}, queremos y(t=15) e v(t=15)
    disp("t = 15");
    disp("c = 0");
    c = 0;
    for k = 0.25 : 0.25 : 1
        [yn, vn] = rk438(t0, y0, v0, 15, deltaT, m, c, k);
        [ye, ve] = solucaoAnalitica(15, y0, v0, m, c, k);
        imprimir(c, k, ye, yn, ve, vn);
    end
    // Para c = 4 e k = {1, 10, 50, 150}, queremos y(t=10) e v(t=10)
    disp("t = 10");
    disp("c = 4");
    c = 4;
    k = [1, 10, 50, 150];
    for i = 1 : 4
        [yn, vn] = rk438(t0, y0, v0, 10, deltaT, m, c, k(i));
        [ye, ve] = solucaoAnalitica(10, y0, v0, m, c, k(i));
        imprimir(c, k(i), ye, yn, ve, vn);
    end
endfunction

function plotar(y0, v0, deltaT, m, c, k, r, n)
    y(1) = y0;
    v(1) = v0;
    yn(1) = y0;
    vn(1) = v0;
    t = [0:n:r]';
    for i = 1:length(t)
        [y(i), v(i)] = solucaoAnalitica(t(i), y0, v0, m, c, k);
        [yn(i), vn(i)] = rk438(t(1), y0, v0, t(i), deltaT, m, c, k);
    end
    //disp(t);
    //disp(y);
    //disp(yn);
    f1 = figure();
    plot(t, y, 'r');
    plot(t, yn, 'b*');
    xlabel("tempo");
    ylabel("posicao");
    legend("analítico", "numérico");
    f2 = figure();
    plot(t, v, 'r');
    plot(t, vn, 'b*');
    xlabel("tempo");
    ylabel("velocidade");
    legend("analítico", "numérico");    
endfunction
