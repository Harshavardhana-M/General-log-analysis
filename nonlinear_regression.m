
clear 
load('swash_sim.mat')
%%
% Define the model function
modelFun = @(b,x) b(1)*x(:,1) + b(2)*x(:,2) + b(3)*x(:,3);

% Define the independent variables and the dependent variable
x = [s1, s2, s3];
y = Theta_1s;

% Define the initial guess for the coefficients
b0 = ones(3, 1);
%set boundary conditions
lb = [-Inf,-Inf,-Inf];
ub = [Inf,Inf,Inf];

%Use difference between predicted values and actual data values as the objective function.
modelFun2 = @(b)modelFun(b,x)-y;
[xlsqnonlin,errorlsqnonlin] = lsqnonlin(modelFun2,b0,lb,ub);

% Display the optimized coefficients
disp(xlsqnonlin);
disp(errorlsqnonlin);

%% Create the optimization problem for lsqnonlin 
problem = createOptimProblem('lsqnonlin', 'x0', b0, 'objective', modelFun2, 'lb',lb, 'ub', ub);

% Create a MultiStart object
ms = MultiStart('UseParallel', true);

% Run MultiStart using lsqnonlin as the local solver
[xmultinonlin,errormultinonlin] = run(ms, problem, 50);

% Display the optimized coefficients
disp(xmultinonlin);
disp(errormultinonlin);

%%
servo=xlsqnonlin(1)*s1+xlsqnonlin(2)*s2+xlsqnonlin(3)*s3;
plot(servo)
hold on;plot(Theta_0)