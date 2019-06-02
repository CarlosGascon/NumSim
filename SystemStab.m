function [Stab, a, y] = SystemStab(Target, option)
% Description: The following function evaluates the system's stable points
% in a (a, e) or (a, m) grid. 

% Input:  - Target: Struct array containing the system's exoplanets
%           information
%         - m: Additional exoplanet's mass in Jupiter masses

% Output: - Stab: Matrix containing the stability time (in log10 years)     
%           for every grid point. -1 indicates a non-imageable
%           point, while 0 refers to a Hill unstable point.
%         - a and e: Semimajor axis and eccentricity vectors respectively

Constants;                       % Import constant values
Stab = zeros(N1, N2);            % Initialize stability matrix

if option == 1                   % Check if option is for (a, e) map
  
    a = linspace(1, 10, N1);     % Create vector of semi-major axis values linearly spaced
    y = linspace(0, 0.5, N2);    % Create vector of eccentricity values linearly spaced
    m = 1;                       % Asign fixed value of mass           

    parpool(Ncores);             % Initiate parallel pool, where Ncores is the number of cores

    parfor (i = 1 : N1, Ncores)  % Run Outer parallel for
        Stabcase = zeros(1, length(y));   % Initiate Stability vector specific iteration
        for j = 1 : length(y)             % Run Inner for

            Stabcase(j) = SingleIntegration(Target, a(i), y(j), m); % Simulate for specific values of a, e and m

        end
        Stab(i, :) = Stabcase;   % Save stability vector into Stab matrix
        1
    end
    
elseif option == 2
    
    a = logspace(log10(0.5), log10(30), N1);
    e = 0.1;
    y = logspace(log10(0.0033), log10(130), N2);

    parpool(Ncores);

    parfor (i = 1 : N1, Ncores)
        Stabcase = zeros(1, length(y));
        for j = 1 : length(y)

            Stabcase(j) = SingleIntegration(Target, a(i), e, y(j));

        end
        Stab(i, :) = Stabcase;
        1
    end
end
    
end

