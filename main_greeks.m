clear, close all
% This is the main code for evaluation of financial greeks using the
% Black-Scholes Model

% Inputs Required:
% Price of the underlying asset (S)
% the Strike price (X)
% the risk-free interest rate (r)
% the time to maturity (t_m)
% the volatility (sig)
% 
% the order of the derivative required (order)
% the parameter to derive with respect to (p1, p2, ...)
%     
% Output:
% the value of the derivative

% (c)LOKO A. loko.aji@icloud.com

a.S = 5000;     % price of asset
a.X = 4950;     % strike price
a.r = 0.06;     % risk-free interest rate
a.t_m = 0.5;    % time to maturity scaled to a year e.g. no. of days left/253 
a.sig = 0.1;    % volatility
opt = 'C';      %(C)all or (P)ut

order = 2;
syms f(S)    % Enter parameters separated by commas if different e.g (S, r) for d2C/dSdr
                % If parameters are same enter once with correspoding order
                % number e.g (S) for d2C/dS2 provided order = 2
param = flip(argnames(f));
p_char = '';
%Get Black-Scholes model equation
BS_model = BS_Model1();

%get the equation for the derivative
for i = 1:order
    if i == 1
        if strcmp(opt,'C')
            func = BS_model.C;
        else
            func = BS_model.P;
        end
    end
   func = jacobian(func,param(end)); 
   p_char = strcat(p_char,'d',char(param(end)));
   param = circshift(param,1,2);
   
end

sprintf('Calculated d%d%s / %s', order, opt, p_char)

%evaluate the derivative
result = eval_BS_Model(func, a.S,a.X,a.r,a.sig,a.t_m)
