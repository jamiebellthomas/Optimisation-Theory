%% Build random transportation problem data
clc
clear
p=3; % num factories
q=5; % num markets
totalSupply=1;
totalDemand=1;
% Experiment with these bits
%% set up demands and supplies
s=rand(p,1);
s=totalSupply*s/sum(s);
d=rand(q,1);
d=totalDemand*d/sum(d);
%% set up coords of supplies and demands
Xs=rand(p,1); Ys=rand(p,1);
Xd=rand(q,1); Yd=rand(q,1);
%% compute a cost matrix
XXs=repmat(Xs,1,q); YYs=repmat(Ys,1,q);
XXd=repmat(Xd',p,1); YYd=repmat(Yd',p,1);
C=((XXs-XXd).^2 + (YYs-YYd).^2).^0.5;  % cost matrix
C_vector = reshape(C',[],1);
X = zeros(p,q)+1;
%Adding the full stop before the asterix means you multiply the respective
%elements rather than doing standard matrix multiplication 
total_cost = sum((C.*X),"all");
% do you see what I am trying to do here?
pq = p*q;
%%find a solution with linprog
%A = functions.populate(p,q);
supply_and_demand_vector = [s;-d];


supply_coefficient_matrix = zeros(p,pq);
it = 0;
first_row_columns = [1:1:q];

for i = 1:size(supply_coefficient_matrix,1)
    supply_coefficient_matrix(i,first_row_columns+(it*q))=1
    it = it+1;
end

demand_coefficient_matrix = zeros(q,pq);
it = 0;
first_row_columns = [1:q:pq];

for i = 1:size(demand_coefficient_matrix,1)
    demand_coefficient_matrix(i,it+first_row_columns)=-1;
    it = it+1;
end

coefficient_matrix = [supply_coefficient_matrix;demand_coefficient_matrix]

[x,fval,exitflag] = linprog(C_vector,coefficient_matrix,supply_and_demand_vector,[],[],zeros(size(C_vector)),[])

X = reshape(x,p,q);
figure;
hold on;
plot(Xs,Ys,'r*');
plot(Xd,Yd,'g*');


