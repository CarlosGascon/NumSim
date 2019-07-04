function [Stab, a, y] = SystemStab(Target, option)
% Description: The following function calculates the numerical stability
% grid of the system specified by Target. Integrations are runned in
% parallel using the number of cores specified by Ncores. For each bin, the
% corresponding two-planet system is integrated via the function
% SingleIntegration.m

% Input:  - Target: Struct containing the system's exoplanet
%           information
%         - option: option indicating the desired stability map (1 for 
%           (a, e) map, 2 for (a, m) map)

% Output: - Stab: Matrix containing the stability time (in log10 years)     
%           for the grid defined by the arrays a and y
%         - a and y: Semimajor axis and eccentricity or mass arrays
%           respectively

% References: 

% - [1] Rein, H. and Liu, S.-F. (2012). Rebound: an open-source multi-purpose n-body code for collisional dynamics.
%       Astronomy & Astrophysics, 537:A128.


Constants;                       % Import constant values
Stab = zeros(N1, N2);            % Initialize stability matrix

if option == 1                   % Check if option is for (a, e) map
  
    a = logspace(log10(2), log10(12), N1);     % Create array of semi-major axis values logarithmically spaced
    y = linspace(0, 0.5, N2);                  % Create array of eccentricity values linearly spaced
    m = 0.1;                                   % Asign fixed value of mass           

    parpool(Ncores);                      % Initiate parallel pool, where Ncores is the number of cores

    parfor (i = 1 : N1, Ncores)           % Run Outer parallel for
        Stabcase = zeros(1, length(y));   % Initiate Stability vector specific iteration
        for j = 1 : length(y)             % Run Inner for

            Stabcase(j) = SingleIntegration(Target, a(i), y(j), m); % Simulate for specific values of a, e and m

        end
        Stab(i, :) = Stabcase;   % Save stability vector into Stab matrix
    end
    
elseif option == 2               % Check if option is for (a, m) map
    
    a = logspace(log10(1.5), log10(25), N1);        % Create array of semi-major axis values logarithmically spaced
    e = 0.05;                                       % Asign fixed value of eccentricity
    y = logspace(log10(0.067), log10(134.45), N2);  % Create array of mass values logarithmically spaced

    parpool(Ncores);                              % Initiate parallel pool, where Ncores is the number of cores

    parfor (i = 1 : N1, Ncores)                   % Run Outer parallel for
        Stabcase = zeros(1, length(y));           % Initiate stability array specific iteration
        for j = 1 : length(y)                     % Run Inner for

            Stabcase(j) = SingleIntegration(Target, a(i), e, y(j)); % Simulate for specific values of a, e and m

        end
        Stab(i, :) = Stabcase;                    % Save stability array into Stab matrix
    end
end
    
end

