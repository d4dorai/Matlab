function [ profit, hist ] = monopolymodel( input_args )
% optimal investment decision model for a monopoly

% ---- common global variables ------------------
global kbar;    %maximum capacity
global tbar;    %maximum time
global a;       %parameter of demand
global b;       %parameter of demand
global g;       %growth factor of demand
global F;       %fixed cost of investment
global bbeta;   %variable cost of investment  
global kstep;   %step function from one capacity to another
global tstep;   %step function from one time to another
global n;       %number of possible capacities
global m;       %number of possible times
global r;       %discount factor

global maxprofit;  % maximum profit
global finalcap;   % final capacity
global decisions;  % investment decisions
%-----------------------------------------------

profit = zeros(m, n);     %initializes profit matrix 

%for T0 (first investment if it exists)   - 
    %calculates what the total profit (at time 50 = end) would be if capacity j*kstep is available starting from T0
%note that hist matrix keeps the evidence of what additional capacity (relative to the previous state)
    %should be bought to reach the desired capacity (j*kstep) 
    
for j = 1 : n
    profit(1, j) = cost(1, 0, (j-1)*kstep);
    hist(1,j) = j-1;
end

%Profit matrix with rows representating time and columns capacity. Each
    %position in the matrix is equal the final total profit if capacity j*kstep
    %would be maintained until the end.
%note that cost is a function that denotes the additional profit
    %brought by an investment decision.

for i = 2 : m   %time   2 --> 50
    for j = 1 : n   %capacity 1 --> 21
        profit(i,j) = profit(i-1, j);       
        hist(i,j) = 0;
        for k = 1 : j    %TODO not better to have j-1  ???
            p = profit(i-1, k) + cost(i, (k-1)*kstep, (j-1)*kstep);
            if (p > profit(i, j))
                profit(i,j) = p;
                hist(i,j) = j-k;
            end
        end
    end
end

%Displays the maximal profit to be obtain and the necessary optimal decision path that should be taken
%plots the investment decision graph
%maxval is maximum profit
%(fcap-1)*kstep is the final capacity that will be had at the end of the 50 years


[maxval, fcap] = max(profit(m, :));
maxprofit = maxval;
finalcap = (fcap-1)*kstep;

l = 0;
for i=m : -1 : 1
    if (hist(i, fcap) ~= 0)
        l = l + 1;
        decisions(l).T = i;
        decisions(l).K = hist(i,fcap)*kstep;
        fcap = fcap - hist(i, fcap);
    end
end
