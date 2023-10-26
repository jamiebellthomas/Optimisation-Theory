clear
clc
maxminusmin = [];
min_matrix = [];
range = 3;
range2 = 2000;
N = linspace(1,range2,range2);
max_min = []
for k = -range:range
outputs = [];
for i = 1:range2
outputs = [outputs (eddieSecretFunction([k;0]).')];
end
% delta_mins = [min(outputs(1,:)) ;min(outputs(2,:))];
% min_matrix = [min_matrix delta_mins];
% maxminusmin = [(max(outputs(1,:))-min(outputs(1,:))) (max(outputs(2,:))-min(outputs(2,:)))];
p = plot(N,sort(outputs(1,:)),'DisplayName',int2str(k));

hold on
end
xlabel('N') 
ylabel('output')
legend
%p = plot(N,sort(outputs(1,:)))
%hold on
%s = plot(N,sort(outputs(2,:)))
%max_min = [max(outputs(1,:));min(outputs(1,:))];
%xlabel('N') 
%ylabel('output') 
%domain = linspace(-range,range,(2*range+1))
%p = plot(domain,min_matrix)

%ALL NOTES AND EQUATIONS ARE ON IPAD