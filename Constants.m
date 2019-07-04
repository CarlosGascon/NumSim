%% Script for loading necessary constant values

% Physical Constants

Msun = 1.98847e30;              % [kg]
Mearth = 5.9723e24;             % [kg]
Mjup = 1.89819e27;              % [kg]
G = 2.8247664e-07;              % [AU^3 / (JupMass * days^2)]
YearDays = 365.2422;            % [days]
r2d = 360 / (2 * pi);           % radians to degrees
d2r = (2 * pi) / 360;           % degrees to radians
m2AU = 6.684587122e-12;         %[AU]

 
% Simulation Constants

rng('shuffle')                   % shuffle seed for random generation                
checktime = 365e4;               % Indicate checktime
dtoutput = checktime / 10;       % Indicate dtoutput
YearsSim = 1e9;
Nparts = 50;                     % Number of parts for time step definition
Nexo = 1;                        % Number of exoplanets (1 or 0)
Ncores = 18;                     % Number of cores for parallel pool
N1 = 70;                         % Number of semimajor axis points
N2 = 40;                         % Number of eccentricity or mass points
