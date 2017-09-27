function y1 = f1(x) //ackley - f(0,0) = 0
    y1 = -20*exp(-0.2*sqrt(0.5*(x(1)^2+x(2)^2))) - exp( 0.5*(cos(2*%pi*x(1)) + cos(2*%pi*x(2))) ) + %e + 20
endfunction

function y2 = f2(x) //beale - f(3,0.5) = 0
    y2 = (1.5 - x(1) + x(1)*x(2))^2 + (2.25 - x(1) + x(1)*x(2)^2)^2 + (2.625 - x(1) + x(1)*x(2)^3)^2 
endfunction

function y3 = f3(x) //goldstein-price - f(0,-1) = 3
    y3 = [1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*x(1)^2-14*x(2)+6*x(1)*x(2)+3*x(2)^2)]*[30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*x(1)^2+48*x(2)-36*x(1)*x(2)+27*x(2)^2)]
endfunction

function y4 = f4(x) //booth - f(1,3) = 0
    y4 = (x(1) + 2*x(2) - 7)^2 + (2*x(1) + x(2) - 5)^2
endfunction

function y5 = f5(x) //bukin - f(-10,1) = 0
    y5 = 100*sqrt(abs(x(2) - 0.01*x(1)^2)) + 0.01*abs(x(1) + 10)
endfunction

function y6 = f6(x) //matyas - f(0,0) = 0
    y6 = 0.26*(x(1)^2 + x(2)^2) - 0.48*x(1)*x(2)
endfunction

function y7 = f7(x) //lévi - f(1,1) = 0
    y7 = sin(3*%pi*x(1))^2+(x(1)-1)^2*(1+sin(3*%pi*x(2))^2)+(x(2)-1)^2*(1+sin(2*%pi*x(2))^2)
endfunction

function y8 = f8(x) //three-hump camel - f(0,0) = 0
    y8 = 2*x(1)^2 - 1.05*x(1)^4 + x(1)^6/6 + x(1)*x(2) + x(2)^2
endfunction

function y9 = f9(x) //eggholder - f(512, 404.2319) = - 959.64066 
    y9 = -(x(2) + 47)*sin(sqrt(abs(x(2) + x(1)/2 + 47))) - x(1)*sin(sqrt(abs(x(1) -(x(2) + 47))))
endfunction

function y10 = f10(x) //mccormick - f(-0.54719,-1.54719) = -1.9133
    y10 = sin(x(1) + x(2)) + (x(1) - x(2))^2 - 1.5*x(1) + 2.5*x(2) + 1
endfunction
