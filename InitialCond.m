function [y_in, dy_in, SysMasses] = InitialCond(Exo)
% Description: The following function returns the initial position and 
% velocity of the two exoplanets and star given by Exo, in heliocentric
% coordinates. The state vector is calculated from the orbital elements
% via the function OE2SV.

% Input: - Exo: Array containing structs with exoplanetary information

% Output: - y_in: Array containing initial position in [AU]
%         - dy_in: Array containing initial velocity in [AU / day]
%         - SysMasses: Array containing system's mass values in [Mjup]

% Comments: Initial conditions are calculated in heliocentric coordinates
% but transformed to a centre of mass reference frame using the
% reb_move_to_com() function in the executable file reboundmex.c

Constants;                                  % Load constant values

ExoInitCond1 = zeros(length(Exo), 6);       % Initialize Exoplanet Initial conditions vector in reference 1
n = length(Exo);                            % Number of exoplanets (known and random)

SysMasses = [Exo(1).smass, [Exo.pmass]];    % Create System masses vector
mus = SysMasses' * G;                       % Create mus vector

t = 0;                                      % Asign time of initial conditions to 0
for i = 1 : n                               % Iterate over all exoplanets
    mu = mus(i + 1) + mus(1);                                               % Calculate particular mu (exoplanet and star)
    ExoInitCond1(i, :) = OE2SV(Exo(i).a, Exo(i).e, Exo(i).I, Exo(i).om, ... % Compute exoplanet initial conditions
                         Exo(i).RAAN, Exo(i).M0, Exo(i).T, mu, t);
end

SysInitPos1 = [zeros(1, 3); ExoInitCond1(:, 1 : 3)];                        % Create System Inital position array                                                         
SysInitVel1 = [zeros(1, 3); ExoInitCond1(:, 4 : 6)];                        % Create system Inital velocity array
                          
y_in = zeros(3 * (n + 1), 1);                                               % Initialize output array
dy_in = zeros(3 * (n + 1), 1);                                              % Initialize output array

for i = 1 : (n + 1)                                                         % Rearrange values for output
    y_in(3 * i - 2 : 3 * i, 1) = SysInitPos1(i, :)';
    dy_in(3 * i - 2 : 3 * i, 1) = SysInitVel1(i, :)';
end

end