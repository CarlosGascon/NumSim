function [Stabtime] = SingleIntegration(KnownExo, a, e, Mexo)
% Description: Given a the known exoplanet's information, an additional
% exoplanet with semi-major axis a, eccentricity e and mass Mexo is 
% generated. The resultant system is then integrated over the period of time 
% specified by 'YearsSim'. While integrating, after a period of time 
% determined by 'checktime', the stability conditions are checked. 
% Depending on the result, the integration continues or ends. Integrations 
% are performed using the Matlab executable file reboundmex.c based on the 
% Leapfrog integrator implemented in the REBOUND package.

% Input: 
    % - KnownExo: Struct containing the information of the known exoplanet 
    % - a: Semi-major axis of the additional planet in [AU]
    % - e: Eccentricity of the additional planet
    % - Mexo: Mass of the additional planet in [Mjup]

% Output: 
    % - Stabtime: Lifetime of the simulation
    
% Comments: Initial conditions are calculated in heliocentric coordinates
% and transformed to a centre of mass reference frame using the
% reb_move_to_com() function in the executable file reboundmex.c
    
% References: 

% - [1] Rein, H. and Liu, S.-F. (2012). Rebound: an open-source multi-purpose n-body code for collisional dynamics.
%       Astronomy & Astrophysics, 537:A128.
    
Constants;                                           % Load constant values    

if Nexo == 1                                         % Check if desired number of exoplanets is 1
    RandomExo = GenerateExo(KnownExo, a, e, Mexo);   % Generate random exoplanet
    Exo = [KnownExo, RandomExo];                     % Create vector containing known and random exoplanet
else
    Exo = KnownExo;                                  % If number of exoplanets is 0, define Exo as KnownExo
end

ExoTab = struct2table(Exo);                          % Convert Exoplanet struct to table
ExoTab = sortrows(ExoTab, 'a');                      % Sort Planet based on the semi-major axis  
Exo = table2struct(ExoTab)';                         % Convert Exoplanet table to struct

[y_in, dy_in, SysMasses] = InitialCond(Exo);              % Calculate system's initial conditions with respect to the star
dt = min([Exo.per]) / Nparts;                             % Time step fixed as T1 / Nparts, where T1 is the period of the innermost planet in [days]
t_in = [dt; YearsSim * YearDays; checktime; dtoutput];    % Array of time parameters: [TimeStep, Simulation duration, checktime, output interval] in [days]   

[t_out, y_out, dy_out] = reboundmex(t_in, y_in, dy_in, SysMasses); % Run integration with matlab executable file written in C.


Stabtime = log10(t_out(end) / YearDays);             % Save duration of simulation


end