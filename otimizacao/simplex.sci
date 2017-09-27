clear
clc

ro = 1		//reflexão
qui = 2		//expansão
gama = 1/2	//contração
sigma = 1/2	//redução

//function y = f(x)
//	y = (x(1) - 2)^4 + (x(1) - 2*x(2))^2
//endfunction

function X = bubbleSort(x)
	n = length(x(1, :))
	for i = 1:n
		for j = 1:n
			if(f(x(:, j)) > f(x(:, i)))
				aux = x(:, i)
				x(:, i) = x(:, j)
				x(:, j) = aux
			end
		end
	end
	X = x
endfunction

function c = centroide(x)
	n = length(x(1, :))-1
	c = x(:, 1)
	for i=2:n
		c = c + x(:, i)
	end
	c = c/n
endfunction

function xr = reflexao(x, c)
	n = length(x(1, :))-1
	xr = (1 + ro)*c - ro*x(:, n+1)

endfunction

function xe = expansao(x, xr, c)
	n = length(x(1, :))-1
	xe = (1 + ro*qui)*c - ro*qui*x(:, n+1)
endfunction

function X = simplex(x)
	x = bubbleSort(x)
	X = x
	booleano = %t
	tolerancia = 1e-5
	erro = f(x(:, 1))
	n = length(x(1, :))-1
	
	cont = 50
	while(cont >= 0)
//	while(erro >= tolerancia)
		c = centroide(x)
		if(booleano)
			plot([X(1,1) X(1,2)],[X(2,1) X(2,2)],'r-')
			plot([X(1,1) X(1,3)],[X(2,1) X(2,3)],'r-')
			plot([X(1,2) X(1,3)],[X(2,2) X(2,3)],'r-')
			booleano = %f
		else
			plot([X(1,1) X(1,2)],[X(2,1) X(2,2)],'k-')
			plot([X(1,1) X(1,3)],[X(2,1) X(2,3)],'k-')
			plot([X(1,2) X(1,3)],[X(2,2) X(2,3)],'k-')
			booleano = %t
		end

		xr = reflexao(x, c)
		if((f(x(:, 1)) <= xr) & (xr < f(x(:, n))))
			x(:, n+1) = xr
		else
			if(f(xr) < f(x(:, 1)))
				xe = expansao(x, xr, c)
				if(f(xe) < f(xr))
					x(:, n+1) = xe
				else
					x(:, n+1) = xr
				end
			else
				if(f(xr) >= f(x(:, n)))
					if((f(x(:, n)) <= f(xr)) & (f(xr) < f(x(:, n+1))))
						xc = (1 + ro*gama)*c - ro*gama*x(:, n+1)
						if(f(xc) <= f(xr))
							x(:, n+1) = xc
						else
							v = x;
							for i = 2:(n+1)
								v(:, i) = x(:, 1) + sigma*(x(:, i) - x(:, 1))
							end
							x = v
						end
					else 
						if(f(xr) >= f(x(:, n+1)))	  
							xc = (1 - gama)*c + gama*x(:, n+1)
							if(f(xc) < f(x(:, n+1)))
								x(:, n+1) = xc
							else
								v = x;
								for i = 2:(n+1)
									v(:, i) = x(:, 1) + sigma*(x(:, i) - x(:, 1))
								end
								x = v
							end
						end
					end
				else
					v = x;
					for i = 2:(n+1)
						v(:, i) = x(:, 1) + sigma*(x(:, i) - x(:, 1))
					end
					x = v
				end
			end
		end
		
		x = bubbleSort(x)
		X = x
		erro = f(x(:, 1))
		cont = cont - 1
		pause
	end
	disp(X)	
endfunction
