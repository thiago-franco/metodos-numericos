close
clear
clc

function g=f(x)
    g=(x(1)-2)^4 + (x(1)-(2*x(2)))^2
endfunction

function U=matriz(y)
	r=0
	for i=1:n
		r=r+y(i)^2
	end
	r=sqrt(r)
	U=eye(n,n)
	for i=1:n
		U(i,i)=y(i)/r
	end
endfunction
function X=Simulated(x,tsa)
	deltar=[.1;.1]
	X(:,$)=x
	n=length(x)
	true=0
	while(true==0)
		true=1
		cont=1000
		t=1
		while(cont>t)
			y=rand(n,1,"normal")
			U=matriz(y)
			xnovo= x + U*deltar
			deltac=f(xnovo)-f(x)
			if(deltac<0)
				x=xnovo
				true=0
			else
				z=exp(-deltac/tsa)
				p=rand(1,1,"uniform")
				if(z>p)
					x=xnovo
					true=0
				end
			end
			t=t+1
		end
		tsa=tsa*0.90
		X(:,$+1)=x
		X=x
	end
endfunction
