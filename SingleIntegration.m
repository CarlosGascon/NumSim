function [Stabtime] = SingleIntegration(KnownExo, a, e, Mexo)
% Description: The following function performs one simulation for a
% specific system. Reading the information from the known exoplanets of the
% particular system, a new random exoplanet is generated. The entire system
% is then integrated over the period of time specified by 'YearsSim'. While
% integrating, after a period of time determined by 'checktime', the
% stability conditions are checked. Depending on the result, the
% integration continues or ends. 

% Input: 
    % - KnownExo: Array formed by the exoplanets contained in the system  
    % analyzed and specified in TargetList. Each array element consists
    % of an exoplanet struct. 
    % - YearsSim: Simulation time in years. 

% Output: 
    % - Stable: Boolean indicating if the simulated case is stable or not.
    
Constants;            % Load constant values    

m = length(KnownExo); % Number of known exoplanets
n = m + Nexo;         % Total number of planets (Known and Random)

if Nexo > 0
    RandomExo = GenerateExo(KnownExo, a, e, Mexo);              % Generate random exoplanet
    Exo = [KnownExo, RandomExo];                % Create vector containing known and random exoplanet
else
    Exo = KnownExo;
end

ExoTab = struct2table(Exo);
ExoTab = sortrows(ExoTab, 'a');
Exo = table2struct(ExoTab)';

[y_in, dy_in, SysMasses] = InitialCond(Exo);      % Calculate system's initial conditions

dt = min([Exo.per]) / Nparts;                    % Time step a ninth of the minimum orbital period of the system   
t_in = [dt; YearsSim * YearDays; checktime; dtoutput];           % Rebound time parameters   

[t_out, y_out, dy_out] = reboundmexmod3(t_in, y_in, dy_in, SysMasses); % Run n body integration with rebound


Stabtime = log10(t_out(end) / YearDays);   


end