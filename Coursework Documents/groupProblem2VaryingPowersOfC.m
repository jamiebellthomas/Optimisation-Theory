clc
clear

data = readtable('ProblemRankData.csv');
data = data{:,:};
original_data = data;

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

    
intcon = 1:pq;
for j = 1:5
    data = original_data.^j;
    [x,fval,exitflag] = intlinprog(transpose(data),intcon,inequality_constraint,inequality_constraint_limits,equality_constraint,equality_constraint_limits,zeros(pq,1),[]);
    x = reshape(x,q,p);
    x = x.';
    
    fval
    exitflag
    average = (fval/p)
    clear size
    %Check these are all 1's ^
    %[MM idx] = unique( sort(x) );
    %counts4 = diff([0;idx]);
   
    if j == 1
        figure
    [r,c] = find(x);
    scatter(c, r, 500, 'r', 'square');
    hold on;
    grid on;
    xlim padded
    ylim padded
    
    end
    if j == 2
    [r,c] = find(x);
    scatter(c, r, 500, 'b', 'o');
    end
    if j == 3
    [r,c] = find(x);
    scatter(c, r, 500, 'g', '^');
    end
    if j == 4
    [r,c] = find(x);
    scatter(c, r, 500, 'k', 'x')
    legend
    xlabel('Group Number');
    ylabel('Student Number');
    end
    if j == 5
    [r,c] = find(x);
    scatter(c, r, 500, 'm', 'pentagram')
    legend
    xlabel('Group Number');
    ylabel('Student Number');
    end
    
    
    for i = 1:p
        for k = 1:q
            if x(i,k) == 0
                data(i,k) = 0;
            end
        end
    end
    allocationSplit = [sum(data(:) == 1) sum(data(:) == 2^j) sum(data(:) == 3^j) sum(data(:) == 4^j)]

end