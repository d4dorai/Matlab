function res = cost(upgradeTime, prevLevel, newLevel)
%cost function that calculates the additional profit brought by a new investment
    %decision; function checks if no new investment decision is made then
    %additional profit will be 0, otherwise the profit formula is calculated
    %according to the rectangle method that estimates the integral.

    global bbeta;
    global m;
    global F;
    global r;
    global g;
    res = 0;
    deltaTime = 0.5;
    if (prevLevel == newLevel)
        return;
    end
    for i = upgradeTime : deltaTime : m
        qtilda = min(demand(i), newLevel);
        Oldqtilda = min(demand(i), prevLevel);
        
         
         %First case: Full Capacity Use    
         %res = res + deltaTime*(price(i, newLevel)*newLevel - price(i,prevLevel)*prevLevel - (F+bbeta*(newLevel - prevLevel)))*exp(-r*i);
        
         %Second case: Early Investment
         res = res + deltaTime*(price(i, qtilda)*qtilda - price(i,Oldqtilda)*Oldqtilda - (F+bbeta*(newLevel - prevLevel)))*exp(-r*i);
     
       
    end
