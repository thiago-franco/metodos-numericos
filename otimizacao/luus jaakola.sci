clc
clear

//function f = problema(x)
//    f = (x(1)-2)^4 + (x(1)-2*x(2))^2;
//endfunction


function otimo = luus_jaakola(x)
    r = [10;10];
    nest = 1000 
    nint = 1000
    dim = length (x);
    e = 0.01;
    for i = 1:nest
        for j = 1:nint   
            R = rand(dim,1)-0.5;
            R = diag(R);
            x_asterisco = x + R*r;     
            if f(x_asterisco) < f(x)        
                x = x_asterisco
             end    
        end
        r = (1-e)*r;
    end
    otimo = x
endfunction
