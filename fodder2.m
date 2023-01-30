%fodder mk2
p = 63;
q = 14;
factor = 10;
data2 = zeros((factor*p),q);
for i = 1:(factor*p)
    data2(i,:) = randperm(q);
end
save("data2","data2","factor")
%%
clc; clear all ;
m = 10 ; 
A = zeros(m);
% introduce random ones 
id = randperm(m*m,20) ; 
A(id) = 1 ;  
[m,n] = size(A) ; 
[Y,X] = meshgrid(1:m,1:n) ; 
idx = find(A) ; 
plot(X(idx),Y(idx),'s','red','r')
%%
M = randi([0 1],25)>0;                                     
[r,c] = find(M);
figure
scatter(c, r, 75, 'sw', 'filled')
set(gca, 'Color','k', 'YDir','reverse')
axis([0 size(M,1)+1  0 size(M,2)+1])
%%
h_air = 1.9e-04
h_batt = 4.8e-05
r1 = 3.3e-04
r2 = 3e-04
r3 = 3.2e-04
t_air = 23
i_main = 0.801109756
i1 = 0.255843435
i2 = 0.281427778
i3 = 0.263838542

r_equiv = 1/(1/r1 + 1/r2 + 1/r3)
i1 = (r_equiv * i_main)/r1
i2 = (r_equiv * i_main)/r2
i3 = (r_equiv * i_main)/r3
i1=0.615009441
i2=0.676510385
i3=0.634228486
h_matrix = [(h_air+h_batt),(-h_batt),0;(-h_batt),(2*h_batt),(-h_batt);0,(-h_batt),(h_batt+h_air)]
t_array = [h_air*t_air+r1*i1^2;r2*i2^2;h_air*t_air+r3*i3^2]
		

T = inv(h_matrix)*t_array
%23.16572044	23.3716881	23.16855663

% final tarray [0.00449482 0.00011347 0.00449872]
%%
m = [4 -2 0;-2 4 -2;0 -2 4]
m_inv = inv(m)
%%
H = [4 -2;-2 10];
f = [-2;-8];
[x,fval,exitflag] = quadprog(H,f)
%%
tic
x = linspace(0,2,100);
y = linspace(0,2,100);
[X,Y] = meshgrid(x,y);
Z = 2.*(X.^2)+5.*(Y.^2)-(2.*X.*Y)-(2.*X)-(8.*Y);
%contour(X,Y,Z,100)

surf(Z)
toc
hold on;
points_x = [0 0.9 17/74 1]
points_y = [0 0.8 34/37 1]
points_z = [0 -4.82 -3.905405 -5]
plot(points_x, points_y,points_z, '+', 'LineWidth', 2, 'MarkerSize', 20)
%%
G = graph([1 1],[2 3])
plot(G,'Layout','force')
%%  
N_r =[2 3 4 5 6 7 8 9 10 11 12 13 20 30 40 50 60 70 80 90 100 110 120 130 140 150 200 250 300 400 500 600]

N_t = [20 30 40 50 60 70 80 90 100 110 120 130 140 150 200 250 300 350 400 450 500 550 600]
t = [0.017 0.021 0.031 0.041 0.059 0.084 0.118 0.176 0.229 0.319 0.410 0.546 0.735 0.867 2.518 5.585 18.626 41.69 73.035 120.707 185.623 281.69 410.978]
R = [1.500 1.857 2.136 2.366 2.560 2.729 2.878 3.012 3.133 3.243 3.345 3.439 3.954 4.45 4.806 5.084 5.312 5.505 5.673 5.821 5.956 6.074 6.183 6.285 6.378 6.466 6.83 7.1125 7.344 7.709 7.993 8.224]
p = plot(N_t,t)
xlabel('N') 
ylabel('Processing Time (s)')
p.Marker = 'o';
p.MarkerFaceColor = 'r';
p.MarkerSize = 6;
p.MarkerFaceColor = [1 0 0];
p.MarkerEdgeColor = [0 0 1];
