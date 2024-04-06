% find equilibrium points
f1 = -x1 + 2*x1^3 + x2;
f2 = -x1 - x2;

sln = solve([f1==0, f2==0], [x1 x2]);
sln.x1
sln.x2

% Create vector field
x = linspace(-1.25,1.25,20);
y = linspace(-1.25,1.25,20);
[X,Y] = meshgrid(x,y);

DX = -X + 2*X.^3 + Y;                 
DY = -X - Y;

N = sqrt(DX.^2+DY.^2); 
quiver(X,Y,DX./N,DY./N,0.3);
xlabel('x_1')
ylabel('x_2')
axis tight equal;
title("Vector Field")

% draws trajectory
hold on
f=@(t,p) [-p1+2*(p1^3)+p2;-p1-p2];
e=[0,1,-1];
c=[0,-1,1];
for k = 1:4
    [t,Sap] = ode45(f,[0 6], [e(k),c(k)]);
    plot(Sap(:,1),Sap(:,2),'LineWidth', 2, 'Color','k')
end
