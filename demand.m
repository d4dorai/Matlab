function q = demand(time)
global g;
global a;
global b;

%MONOPOLY
q = (a /(2 * b))*exp(g*time);

%SOCIAL WELFARE MAXIMIZER
%q = (a /(b))*exp(g*time);
