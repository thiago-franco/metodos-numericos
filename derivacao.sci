function y = f(x)
    // Função cuja derivada deseja ser estimada
    y = exp(x) + sin(x)
endfunction

// Derivada recuada com dois pontos 
function D = recuada(x, h)
    D = (f(x)-f(x-h))/h
endfunction

function D = avancada(x,h)
    D = (f(x+h)-f(x))/h
endfunction

function D = centrada(x,h)
    D = (f(x+h)-f(x-h))/2*h
endfunction

function D = derivadaSegunda(x,h)
    D = (f(x+h)-2*f(x)+f(x-h))/(h^2)
endfunction
