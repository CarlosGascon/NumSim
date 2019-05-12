function [Stab, a, e, PerStab] = SystemStab(Target)
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

a = linspace(1, 10, N1);
e = linspace(0, 0.5, N2);

parpool(Ncores);

parfor (i = 1 : N1, Ncores)
    Stabcase = zeros(1, N2);
    for j = 1 : N2
        
        Stabcase(j) = SingleIntegration(Target, a(i), e(j), m);
    
    end
    Stab(i, :) = Stabcase;
    
end

end

