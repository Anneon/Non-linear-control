clear;
syms a positive
syms b nonzero
syms x1 x2

E = 0.2;
R = 0.2;
C = 2;
L = 5;

% find equilibrium points
h = poly2sym([83.72 -226.31 229.62 -103.79 17.767 0], x1);
f1 = 1/C*(-h + x2);
f2 = 1/L*(-x1 - R*x2 + E);

sln = solve([f1==0, f2==0], [x1 x2]);
vpa(sln.x1,2) % variable precision (2 sig figs)
vpa(sln.x2,2)

% Jacobian
J = jacobian([f1 f2], [x1 x2]);
for i=1:numel(sln.x1)

    % skip the imaginary eq. points
    s1 = vpa(sln.x1(i));
    s2 = vpa(sln.x2(i));
    if ~isreal(s1) || ~isreal(s2)
        continue
    end
    
    disp('Equilibrium Point: ')
    disp(vpa([s1 s2], 2))
    A = subs(J,[x1 x2], [s1 s2]);
    disp('Eigenvalues: ')
    disp(vpa(eig(A), 2))
end