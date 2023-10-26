clc
clear
clear size
data = readtable('ProblemRankData.csv');
data = data{:,:};

% size = size(data)
% p = size(1,1);
% q = size(1,2);
load("data2.mat")
size = size(data2)
p = size(1,1);
q = size(1,2);

pq = p*q;


average_group_size = p/q;
g_max = round(average_group_size+1);
g_min = round(average_group_size-1);


equality_constraint = zeros(p,pq);
for i = 1:p
    for k = 1:q
        equality_constraint(i,k+(q*(i-1))) = 1;    

    end
end
equality_constraint_limits = ones(p,1);



%equ_rows = sum(equality_constraint,2)



inequality_constraint = repmat(eye(q),1,p);
inequality_constraint = [inequality_constraint ; -(inequality_constraint)];
inequality_constraint_limits=[(ones(q,1)*g_max);(ones(q,1)*g_min*-1)];
intcon = 1:pq;


%inequ_rows = sum(inequality_constraint,2)
for k = 1:5
    r = k
    r_constraint_limit = ones(p,1)*r;
    r_constraint = [];
    for i = 1:p
        r_constraint_row = [zeros(1,(q*(i-1))) (data2(i,:)) zeros(1,q*(p-i))];
        r_constraint = [r_constraint ; r_constraint_row];
    end
    
    %inequality_constraint = [inequality_constraint;r_constraint];
    %inequality_constraint_limits = [inequality_constraint_limits;r_constraint_limit];
    
    
    
    
    [x,fval,exitflag] = intlinprog(transpose(data2),intcon,[inequality_constraint;r_constraint],[inequality_constraint_limits;r_constraint_limit],equality_constraint,equality_constraint_limits,zeros(pq,1),[]);
%     x = reshape(x,q,p);
%     x = x.';
%     
%     fval
%     exitflag
    average = fval/p
% 
%     columns = sum(x);
%     
%     rows = sum(x,2);
%     %Check these are all 1's ^^
%     student_count_sum_in_each_project = sum(rows);
%     
%     
%     for i = 1:p
%         for k = 1:q
%             if x(i,k) == 0
%                 data2(i,k) = 0;
%             end
%         end
%     end
end