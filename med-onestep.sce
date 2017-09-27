// Métodos One-Step para resolução de Equações Diferenciais Ordinárias

clc
clear

function F=f(x,y)
    // A equação diferencial a ser solucionada, na forma dy/dx = f(x,y)
    F = 0.5*sin(x)-0.02*y;
endfunction

function Y = euler(a,b, yk, h)
    x(1) = a;
    y(1)=yk;
    //m = 10;
    m = (b-a)/h;
    for i=1:m
        x(i+1)=x(i)+h;
        y(i+1)=y(i)+h*f(x(i),y(i));
    end
    Y = y
endfunction

function Y=heun(a,b, yk, h)
    x(1) = a;
    y(1)=yk;
    //y0(1)=Euler(a,b,yk,h);
    y0(1)=yk;//opcional, so pra criar o vetor
    m = (b-a)/h;
    for i=1:m
        x(i+1)=x(i)+h;
        V = euler(a,b,yk,h);
        y0(i+1)= V(m);
        y(i+1) = y(i) + (f(x(i),y(i))+f(x(i+1),y0(i+1)))*h/2;
    end
    Y = y
endfunction

function Y = eulerModificado(a,b, yk, h)
    x(1) = a;
    y(1)=yk;
    xm(1)=x(1)+h/2;
    m = (b-a)/h;
    for i=1:m
        x(i+1)=x(i)+h;
        xm(i+1)=x(i+1)+h/2;
        ym(i)=y(i)+f(x(i),y(i))*h/2;
        y(i+1)=y(i)+h*f(xm(i),ym(i));
    end
    Y = y
endfunction

function Y=runge-kutta1(a,b, yk, h)
    Y =  euler(a,b, yk, h)
endfunction

function Y=runge-kutta2(a, b, y0, h)
    x(1) = a;
    y(1) = y0;
    m = (b-a)/h;
    for i=1:m
        k1=f(x(i),y(i));
        k2=f(x(i)+h, y(i)+h*f(x(i),y(i)));
        y(i+1)=y(i)+(k1+k2)*h/2;
        x(i+1)=x(i)+h;
    end
endfunction

function Y=runge-kutta3(a,b, yk, h)
    x(1) = a;
    y(1)=yk;
    m = (b-a)/h;
    for i=1:m
        k1 = h* f(x(i),y(i));
        k2 = h*f(x(i)+0.5*h,y(i)+0.5*k1);
        k3 = h*f(x(i)+h, y(i)+2*k2-k1);
        y(i+1)=y(i)+1/6*(k1+4*K2+k3);
        x(i+1)=x(i)+h;
    end
    Y = y
endfunction

function Y=runge-kutta4(a, b, y0, h)
    x(1) = a;
    y(1) = y0;
    m = (b-a)/h;
    for i=1:m
        k1 = f(x(i),y(i));
        k2 = f(x(i)+0.5*h, y(i)+0.5*k1);
        k3 = f(x(i)+0.5*h, y(i)+0.5*k2);
        k4 = f(x(i)+h, y(i)+k3);
        y(i+1)=y(i) + 1/6 * (k1+2*(k2+k3)+k4);
        x(i+1)=x(i);
    end
    Y = y;
endfunction
