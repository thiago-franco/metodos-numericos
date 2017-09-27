// Métodos de Integração Numérica

function y = f(x)
    // Função cuja integral deseja ser calculada
    y = exp(x) + sin(x)
endfunction

// Aproximação de integral definida de a até b pela regra dos retângulos 
function I = retangulos(a,b)
    I = (b-a)*f((a+b)/2)
endfunction

function I = trapezios(a,b)
    I = (b-a)*(f(a)+f(b))/2
endfunction

function I = simpson(a,b)
    I = (b-a)*(f(a)+4*f((a+b)/2)+f(b))/6
endfunction
