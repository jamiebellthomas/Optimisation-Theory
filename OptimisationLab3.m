H1 = [1 -1;-1 2]
H2 = [1 -1;-1 -2]
f = [-2 -6]
A = [1 1;-1 2;2 1]
b = [2;2;3]
Aeq = []
beq = []
lb =[]
ub = []
[x1,fval,exitflag,output,lambda] = quadprog(H1,f,A,b,Aeq,beq,lb,ub)
[x2,fval,exitflag,output,lambda] = quadprog(H2,f,A,b,Aeq,beq,lb,ub)
[v1,d1] = eig(H1)
[v2,d2] = eig(H2)
% returns diagonal matrix D of eigenvalues and matrix V whose columns are the corresponding right eigenvectors, so that H*V = V*D.

fun = @(x)0.5*(x(1))^2-x(2)^2-x(1)*x(2)-2*x(1)-6*x(2)
x0 = [0 0]

x3 = fmincon(fun,x0,A,b)
%Same as x1


