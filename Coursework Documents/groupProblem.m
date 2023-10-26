clc
clear
%
data = readtable('ProblemRankData.csv');
data = data{:,:}.';
size = size(data)
p = size(1,2);
q = size(1,1);
g_max = 5;
g_min = 3;
pq = p*q;
%Equality restraint
equality_constraint = repmat(eye(p),1,q);
equality_constraint_limit = ones(p,1);

%Inequality restraint
inequality_constraint = zeros(q,pq);
it = 0
for i = 1:q
    it = it+1;
    for k = 1:p
        inequality_constraint(i,k+(p*(it-1))) = 1;    

    end
end
inequality_constraint = [inequality_constraint ; -(inequality_constraint)];
inequality_constraint_limits=[(ones(q,1)*g_max);(ones(q,1)*g_min*-1)];

%r restriction
%THIS ISNT WORKING. NEEDS FIXING
r = 7
r_constraint_limit = ones(p,1)*r;
r_constraint = []

for i = 1:p
    r_constraint_row = [zeros(1,(q*(i-1))) transpose(data(:,i)) zeros(1,q*(p-i))];
    r_constraint = [r_constraint ; r_constraint_row];
end
inequality_constraint = [inequality_constraint;r_constraint];
inequality_constraint_limits = [inequality_constraint_limits;r_constraint_limit];

%intlinprog calc
intcon = 1:pq;
[x,fval,exitflag] = intlinprog(data,intcon,inequality_constraint,inequality_constraint_limits,equality_constraint,equality_constraint_limit,zeros(pq,1),[]);
x = reshape(x,[q,p])
average = fval/p
fval
columns = sum(x,2)
%Check these are all 1's ^^
rows = sum(x)
student_count_sum_in_each_project = sum(rows);

% for i = 1:p
%     for k = 1:q
%         if x(k,i) == 0
%             data(k,i) = 0;
%         end
% 
% 
%     end
% end
% 
% % 








