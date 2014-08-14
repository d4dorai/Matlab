function [ profit, hist ] = singlerun(showDialog)
% optinvest part: runs a single calculation / simulation and optionally displays a dialog box for input variable variation

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

% values, we are looking for
global maxprofit;  % maximum profit
global finalcap;   % final capacity
global decisions;  % investment decisions

if showDialog == 1
    % configure dialog
    prompt = {'kbar'; 'tbar'; 'a'; 'b'; 'g'; 'F'; 'bbeta'; 'kstep'; 'tstep'; 'r'};
    defVal = { '2000'; '50'; '100'; '0.1'; '0.01'; '240'; '0.1'; '100'; '1'; '0.07' };
    title = 'Single Run';
    lines = 1;
    % display dialog
    answer = inputdlg(prompt, title, lines, defVal);
    
    if ~isempty(answer)
        % if OK button was clicked and we got an answer, use the variables
        % from the answer and assign it to the global workspace variables
        ws = 'base';  % workspace
        assignin(ws, 'kbar', str2double(answer(1)));
        assignin(ws, 'tbar', str2double(answer(2)));
        assignin(ws, 'a', str2double(answer(3)));
        assignin(ws, 'b', str2double(answer(4)));
        assignin(ws, 'g', str2double(answer(5)));
        assignin(ws, 'F', str2double(answer(6)));
        assignin(ws, 'bbeta', str2double(answer(7)));
        assignin(ws, 'kstep', str2double(answer(8)));
        assignin(ws, 'tstep', str2double(answer(9)));
        assignin(ws, 'r', str2double(answer(10)));
        % print the variables
        variables = strcat(prompt, ' = ', answer)
        % actually perform a single run
        [ profit, hist ] = doSingleRun();
        % after the run is done, save all variables in a file
        save('optinvest-singlerun.mat');
    else
        disp('Cancelled.')
    end
elseif showDialog == 0
    % just performs a single run without displaying a dialog
    % useful for simulation, then we silently assume here that the values
    % were already assigned.
    [ profit, hist ] = doSingleRun();
else
    error('Invalid value for showDialog supplied: %s. Only 0 (false) or 1 (true) allowed.', showDialog)
end


function [ profit, hist ] = doSingleRun()
global kbar;    %maximum capacity
global tbar;    %maximum time
global kstep;   %step function from one capacity to another
global tstep;   %step function from one time to another
global n;       %number of possible capacities
global m;       %number of possible times

n = (kbar / kstep) + 1;
m = tbar / tstep;
disp('Running Monopoly...')
[ profit, hist ] = Monopoly();
disp('Finished.')
