function res = price(time, d)
%calculates the price
    global a;
    global b;
    global g;
    
    %MONOPOLY
    res = a - b * exp(-g*time)*d;
    
    %SOCIAL WELFARE MAXIMIZER
    %res = a - (b/2) * exp(-g*time)*d;
