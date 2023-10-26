clc
clear
tic
dummyx = linspace(-512,512,500);
dummyy = linspace(-512,512,500);
[xx,yy]=meshgrid(dummyx,dummyy);
zz = -1.*(yy+47).*sin((abs(0.5.*xx+yy+47)).^0.5)-xx.*sin(((abs(xx-(yy+47))).^0.5));
% This is the EggHolder function
% Reference:
% https://en.wikipedia.org/wiki/Test_functions_for_optimization
% s = surf(xx,yy,zz)
%%
% Change
p = contour(xx,yy,zz);
hold on
bigIt = 0
bestf = 0
bestf_coords = []
best_X = []
best_V = []
best_b_local = []
best_b_vicinity = []
optimum = -959.6407
while bigIt < 100
bigIt = bigIt + 1;
bestf;
%minimum --> f(512,404.2319)=-959.6407

%%

n_particles = 2000;
upper = 512;
lower = -512;
X = (upper-lower)*rand(2,n_particles)+lower;
f = X(1,:);
b_vicinity = X(:,find(f==min(f)));
b_vicinity_value = min(f);
b_local = X;
b_local_value = f;
w = 0.3;
c1 = 0.87;
c2 = 0.13;
V = rand(2,n_particles);
iteration_count = 200;
it = 0;
%%
while it < iteration_count
    it = it+1;
    r = rand(1,1);
    %c2 = it/iteration_count;
    %c1 = 1-c2;
    V = w*V+c1.*r(1,1)*(b_local-X)+c2.*(1-r(1,1))*(b_vicinity-X);
    X = X+V;
    maxX = max(X);
    for i = 1:n_particles
        if abs(maxX(1,i))>512
            X(:,i)=X(:,i)-V(:,i);
        end
    end
    x = X(1,:);
    y = X(2,:);
    f = -1.*(y+47).*sin((abs(0.5.*x+y+47)).^0.5)-x.*sin(((abs(x-(y+47))).^0.5));
    for i = 1:n_particles
        if f(1,i)<b_local_value(1:i)
            b_local(:,i)=X(:,i);
        end
    end
    if min(f)<b_vicinity_value
        b_vicinity_value = min(f);
        coords = X(:,find(f==min(f)));
        b_vicinity(:,1) = coords(:,1);
    end

    
end
x = b_vicinity(1,1);
y = b_vicinity(2,1);
f = -1.*(y+47).*sin((abs(0.5.*x+y+47)).^0.5)-x.*sin(((abs(x-(y+47))).^0.5));
if f < bestf
    disp("new best iteration")
    bigIt
    bestf = f
    bestf_coords = [b_vicinity(1,1) b_vicinity(2,1)];
    best_X = X;
    best_V = V;
    best_b_local = b_local;
    best_b_vicinity = b_vicinity;
    
  
end
if bestf<optimum
    %This is just here for error catching purposes
    disp("optimum either reached or exceeded")
    break

end
end
X = best_X;
V = best_V;
b_local = best_b_local;
b_vicinity = best_b_vicinity;
w = 0.25;
c1 = 0.4;
c2 = 0.6;
for m = 1:100
    r = rand(2,1);
    V = w*V+c1.*r(1,1)*(b_local-X)+c2.*r(2,1)*(b_vicinity-X);
    X = X+V;
    maxX = max(X);
    for i = 1:n_particles
        if abs(maxX(1,i))>512
            X(:,i)=X(:,i)-V(:,i);
        end
    end
    x = X(1,:);
    y = X(2,:);
    f = -1.*(y+47).*sin((abs(0.5.*x+y+47)).^0.5)-x.*sin(((abs(x-(y+47))).^0.5));
    for i = 1:n_particles
        if f(1,i)<b_local_value(1:i)
            b_local(:,i)=X(:,i);
        end
    end
    if min(f)<b_vicinity_value
        b_vicinity_value = min(f);
        coords = X(:,find(f==min(f)));
        b_vicinity(:,1) = coords(:,1);
    end
end

    quiver(X(1,:),X(2,:),V(1,:),V(2,:));
    scatter(X(1,:),X(2,:));
%     x_conv = [-465.6924 -457.0550 512]
%     y_conv = [385.7167 -383.3147 404.2319]
%     plot(x_conv, y_conv,'+','MarkerSize', 15)

%     quiver(best_X(1,:),best_X(2,:),-best_V(1,:),-best_V(2,:));
%     scatter(best_X(1,:),best_X(2,:));
    x_conv = [-465.6924 -457.0550 512]
    y_conv = [385.7167 -383.3147 404.2319]
    plot(x_conv, y_conv,'+','MarkerSize', 15)
    plot(bestf_coords(1,1), bestf_coords(1,2),'*','MarkerSize', 25)


%-894.57 something (-454.8615,381.3727)
%-786.52 something (-457.0550,-383.3147)
%It wasnt finding the minimum point because it is right on the edge
%(x=512), so whenver it crosses the edge it is sent the back in and more
%meaning it never reaches 512
%aim = 512,404.2319
b_vicinity_value
b_vicinity
toc