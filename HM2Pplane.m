close all
[x,y] = meshgrid(-5:.2:5,-5:.2:5);
u= -x+2*x^3+y;
v= -x-y;
l = sqrt(u.^2+v.^2);
quiver(x,y,u./l,v./l,.5,'k')
axis equal tight
hold on
f= @(t,P) [-P(1)+2*P(1)^3+P(2); -P(1)-P(2)];
a = [0 1 -1 -1];
b = [0 -1 1 1.1];
for k = 1:numel(a)
    [t,s] = ode45(f,[0 3], [a(k) b(k)]);
    plot(s(:,1),s(:,2),'b-')
end
hold off