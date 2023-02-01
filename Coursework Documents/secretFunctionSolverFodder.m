clear
results = []
    for i = 1:10000
        results = [results eddieSecretFunction([0;0])];
    end
    p = plot((1:10000),sort(results),'DisplayName',int2str(0));
    hold on
    max(results)
    min(results)
legend

%%
mins2 = []
deltas = []
for k = -50:50
results = [];
for i = 1:10000
results = [results eddieSecretFunction([k;0])];
end
deltas = [deltas max(results)-min(results)];
result = [k;min(results)];
mins2=[mins2 result];
%plot(1:100,sort(results),'DisplayName',int2str(k))
%hold on
end
%legend

%%
clc
min_matrix = [];
range = 50;
range2 = 5000;
N = linspace(1,range2,range2);
for k = -range:range
outputs = [];
for i = 1:range2
outputs = [outputs (eddieSecretFunction([k 0]).')];
end
mins = [min(outputs(1,:)); min(outputs(2,:))];
min_matrix = [min_matrix mins];
end
x = linspace(-range,range,(2*range+1));
%p = plot(N,sort(outputs(1,:)))
%hold on
%s = plot(N,sort(outputs(2,:)))
%max_min = [max(outputs(1,:));min(outputs(1,:))];
%xlabel('N') 
%ylabel('output') 
%domain = linspace(-range,range,(2*range+1))
%p = plot(domain,min_matrix)

%ALL NOTES AND EQUATIONS ARE ON IPAD
%%
%Test output equation
clc
clear
maxmin = 500
ran = rand(1,1)
x = linspace(-100,100,201);
y = linspace(-100,100,201);
[xx yy]=meshgrid(x,y);
zz = 500*rand+xx.^2-4.*xx+yy.^2-8.*yy+20; 
contour(xx,yy,zz)
hold on
plot(8,16,'+')
plot(2,4,'+')

