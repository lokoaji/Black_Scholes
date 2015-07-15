function [Zh, Jac, Hes] = eval_BS(input, Model)
% This function uses the input parameters to evaluate:
% the Black-Scholes Call option price estimate [Zh]
% the Jacobian of the Black-Scholes [Jac]
% the Hessian of the Black-Scholes [Hes]

k = input.k - 1;
S = input.S(k);
X = input.X;    % Strike price 
t_m = input.real_in(k,2);
X_p = input.X_a;    % State vector
[Nx1, Nx2] = size(X_p);

if Nx2 == 1
    sig = X;
    r = input.r(k);
    Jac = Model.dCs(S,X,r,sig,t_m); % evaluate the Jacobian
    Hes = Model.Hes1(S,X,r,sig,t_m); % evaluate the Hessian
    
elseif Nx2 == 2
    sig = X_p(1); r = X_p(2);
    Jac = Model.Jac1(S,X,r,sig,t_m); % evaluate the Jacobian
    Hes = Model.Hes1(S,X,r,sig,t_m); % evaluate the Hessian
    %Hes2 = Model.Hes2(S,X,r,sig,t_m);
end

% measurement estimate
Zh = Model.C(S,X,r,sig,t_m);

end