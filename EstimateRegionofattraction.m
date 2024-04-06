clear;
syms a positive
syms b positive
syms x1 x2 x

% find equilibrium points
f1 =x1 - x1^3 + x2;
f2 = 3*x1 - x2;

sln = solve([f1==0, f2==0], [x1 x2]);
sln.x1
sln.x2

% jacobian
J = jacobian([f1 f2], [x1 x2])
for i=1:numel(sln.x1)
    disp('===============================')
    disp('Equalibrium Point: ')
    disp([sln.x1(i) sln.x2(i)])
    A = subs(J,[x1 x2], [sln.x1(i) sln.x2(i)]);
    disp('Eigenvalues: ')
    disp(eig(A))
end
Q = eye(2);
P = lyap(A',Q)

% % Define the Lyapunov function candidate for the equilibrium point (-2,-6)
% a = 1; % choose a positive value for a
% b = 0.5; % choose a value for b such that b^2 < ac
% c = 2; % choose a positive value for c
% Q = [a b; b c];
% V = 0.5*x'*Q*x;
% 
% % Evaluate the Lyapunov function on a grid of points
% x1 = linspace(-10,10,100);
% x2 = linspace(-10,10,100);
% [X1,X2] = meshgrid(x1,x2);
% Vvals = V*([X1(:) X2(:)]);
% Vgrid = reshape(Vvals,length(x2),length(x1));
% 
% % Find the level set corresponding to V = 1
% [c,h] = contour(X1,X2,Vgrid,[1 1],'r');
% Define the Lyapunov function
%P = [1 -3/2; -3/2 3];
[x1, x2] = meshgrid(-3:0.1:3);
V = (P(1,1)*x1.^2 + 2*P(1,2)*x1.*x2 + P(2,2)*x2.^2);

% Plot the level sets of the Lyapunov function
contour(x1, x2, V, 'LevelList', [0.01 0.05 0.1 0.2 0.5 1 2], 'LineWidth', 1.5);
axis equal;
grid on;
xlabel('x_1');
ylabel('x_2');
title('Region of attraction estimate');

% Define the matrix P
% P = [1 -3/2; -3/2 3];

% Define the function handle for V(x)
V = @(x) 0.5 * x' * P * x;

% Define the function handle for dotV(x)
dotV = @(x) -(x(1)^2 - 9/8*x(2))^2 - 15/64*x(2)^2;

% Create a grid of points for x1 and x2
x1 = linspace(-3, 3, 100);
x2 = linspace(-3, 3, 100);
[X1, X2] = meshgrid(x1, x2);
X = [X1(:), X2(:)];

% Compute the values of V and dotV for each point in the grid
V_values = zeros(size(X, 1), 1);
dotV_values = zeros(size(X, 1), 1);
for i = 1:size(X, 1)
    V_values(i) = V(X(i, :)');
    dotV_values(i) = dotV(X(i, :)');
end

% Reshape the values into a matrix for plotting
V_values = reshape(V_values, size(X1));
dotV_values = reshape(dotV_values, size(X1));

% Plot the contours of V(x) and dotV(x)
figure
contour(X1, X2, V_values, 20, 'linewidth', 1.5)
hold on
contour(X1, X2, dotV_values, [0 0], 'k', 'linewidth', 2)
title('Estimate of Region of Attraction', 'fontsize', 16)
xlabel('x1', 'fontsize', 14)
ylabel('x2', 'fontsize', 14)
axis equal
grid on