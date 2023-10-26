clc
help linprog
%%
%Tea drinking

A = [2 1;1 2]
B = [8;10]
C = [-1;-1]

[x,fval,exitflag] = linprog(C,A,B,[],[],zeros(2,1),[])
%%
%Grain mix

%linprog([OBJECTIVE FUNCTION],[INEQUALITY COEFFICIENTS (less than or equal)],[INEQUALITY LIMITS],[EQUALITY COEFFICIENTS],[EQUALITY VALUES],[LOWER LIMIT],[UPPER LIMIT])
D = [6 3;6 6;2 6]
E = [60;84;36]
F = [5;4]

[x,fval,exitflag] = linprog(F,-D,-E,[],[],zeros(2,1),[])
%Set -D and -E because inequalities in the question are greater than, we
%need to flip this by dividing both sides by -1
%%
%Clifton metal artwork

G = [2/3 1/4;1/3 3/4]
H = [5;5]
I = -[1;2]
[x,fval,exitflag] = linprog(I,G,H,[],[],zeros(2,1),[7;6])
%%
%Tea with slack variables

A_slack = [2 1 1 0;1 2 0 1]
B = [8;10]
C = [-1;-1;0;0]

[x,fval,exitflag] = linprog(C,[],[],A_slack,B,zeros(4,1),[])

%%
%Grain with slack
D_slack = [-6 -3 1 0 0;-6 -6 0 1 0;-2 -6 0 0 1]
E = [60;84;36]
F_slack = [5;4;0;0;0]

[x,fval,exitflag] = linprog(F_slack,[],[],D_slack,-E,zeros(5,1),[])
%SLACK VARIABLES ARENT MADE NEGATIVE
%ONLY INVERT THE ACTUAL VARIABLES
%%
%Clifton metal artwork with slack variables

G_slack = [2/3 1/4 1 0;1/3 3/4 0 1]
H = [5;5]
I_slack = -[1;2;0;0]
[x,fval,exitflag] = linprog(I,G,H,[],[],zeros(4,1),[7;6;0;0])
%%
clear
%Transportation Problem
p = 3 %no of factories
q = 2 %no of markets
x = zeros(p,q);
c = zeros(p,q);
cost = transpose(x(:))*c(:);

