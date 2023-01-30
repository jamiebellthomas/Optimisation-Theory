clc
clear

data = readtable('ProblemRankData.csv');
data = data{:,:};
size = size(data);
p = size(1,1);
q = size(1,2);
pq = p*q;
g_max = 5;
g_min = 3;

equality_constraint = zeros(p,pq);
for i = 1:p
    for k = 1:q
        equality_constraint(i,k+(q*(i-1))) = 1;    

    end
end
equality_constraint_limits = ones(p,1);

inequality_constraint = repmat(eye(q),1,p);
inequality_constraint = [inequality_constraint ; -(inequality_constraint)];
inequality_constraint_limits=[(ones(q,1)*g_max);(ones(q,1)*g_min*-1)];

r = 4
r_constraint_limit = ones(p,1)*r;
r_constraint = [];
for i = 1:p
    r_constraint_row = [zeros(1,(q*(i-1))) (data(i,:)) zeros(1,q*(p-i))];
    r_constraint = [r_constraint ; r_constraint_row];
end

inequality_constraint = [inequality_constraint;r_constraint];
inequality_constraint_limits = [inequality_constraint_limits;r_constraint_limit];


intcon = 1:pq;

[x,fval,exitflag] = intlinprog(transpose(data),intcon,inequality_constraint,inequality_constraint_limits,equality_constraint,equality_constraint_limits,zeros(pq,1),[]);
x = reshape(x,q,p);
x = x.';

fval
exitflag
average = fval/p

columns = sum(x);

rows = sum(x,2);
%Check these are all 1's ^^
student_count_sum_in_each_project = sum(rows);


for i = 1:p
    for k = 1:q
        if x(i,k) == 0
            data(i,k) = 0;
        end
    end
end