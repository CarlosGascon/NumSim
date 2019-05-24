function [Stab, a, y] = SystemStab(Target, option)
% Description: The following function evaluates the system's imageable and
% stable points in a semimajor axis - eccentricity axis. 

% Input:  - Target: Struct array containing the system's exoplanets
%           information
%         - m: Additional exoplanet's mass in Jupiter masses

% Output: - Stab: Matrix containing the stability time (in log10 years)     
%           for every grid point. -1 indicates a non-imageable
%           point, while 0 refers to a Hill unstable point.
%         - a and e: Semimajor axis and eccentricity vectors respectively
%         - PerStab: Percentage of stable orbits
Constants;
Stab = zeros(N1, N2);

if option == 1
  
    a = linspace(1, 10, N1);
    y = linspace(0, 0.5, N2);
    m = 1;

    parpool(Ncores);

    parfor (i = 1 : N1, Ncores)
        Stabcase = zeros(1, length(y));
        for j = 1 : length(y)

            Stabcase(j) = SingleIntegration(Target, a(i), y(j), m);

        end
        Stab(i, :) = Stabcase;
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

