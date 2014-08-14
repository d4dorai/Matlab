function result = getResult(showPlot)
% get the result of the last single run of optimal investment calculation
global maxprofit;
global finalcap;
global decisions;
global tbar;

strmaxval = strcat('Maximum profit = ', num2str(maxprofit, '%f'));
strfcap = strcat('Final capacity = ', num2str(finalcap, '%d'));
actions = '> Actions to be taken:';

%add actions
for c=length(decisions):-1:1
    actions = strvcat(actions, sprintf('-> Increase capacity with %d at time %d', decisions(1, c).K, decisions(1, c).T));
end
% ourput result
result = strvcat(strmaxval, strfcap, actions);

% only plot, when we have a single run, otherwise we do not want to plot
% each run...
if showPlot == 1
    %nicely plot the output;
    ti = 1:1:tbar;
    plot(ti,demand(ti),'r');
    xlabel('time');
    ylabel('capacity');
    hold;
    
    %plot the people's demand
    %ti = 1:1:tbar;
    %plot(ti,demandSW(ti),'g');
    
    capacity = 0;
    for ll = length(decisions): -1 : 2
        time = decisions(ll).T : 1 : decisions(ll-1).T;
        capacity = capacity + decisions(ll).K;
        plot(time,0*time + capacity);
    end
    time = decisions(1).T:1:tbar;
    capacity = capacity + decisions(1).K;
    plot(time,0*time + capacity);
    legend('optimal quantity of monopolist','capacity limit','Location','Best');

    hold;
end
