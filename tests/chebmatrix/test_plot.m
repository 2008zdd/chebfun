function pass = test_plot
% HM, 30 Apr 2014

%% 
% A has entries of all types: OPERATORBLOCK, FUNCTIONBLOCK,
% CHEBFUN and DOUBLE.

d = [-2 2];                   % function domain
I = operatorBlock.eye(d);     % identity operator
D = operatorBlock.diff(d);    % differentiation operator
x = chebfun(@(x) x, d);       % the variable x on d
M = operatorBlock.mult(x.^2); % multiplication operator
S = functionalBlock.sum(d);   % integration functional 
E = functionalBlock.eval(d);  % evaluation functional generator
A = [ I+D, abs(x), M; S, 0, E(2); D, x.^2, I ];
figure, plot(A);

%% 
% The entries of A are only CHEBFUN or DOUBLE.

d = [-1 1];                     
f = chebfun(@(x) x, d);         
g = chebfun(@(x) exp(x), d);
A = [f, g; 2*f, 3*g];
figure, plot(A)

end