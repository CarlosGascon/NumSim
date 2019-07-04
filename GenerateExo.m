function [RandomExo] = GenerateExo(KnownExo, a, e, m)
% Description: The following function generates an additional exoplanet
% struct with given values of semi-major axis, eccentricity and mass. 

% Input:
    % - KnownExo:  Struct containing the information of the known exoplanet 
    % - a: Additional planet's semi-major axis in [AU]
    % - e: Additional planet's eccentricity 
    % - m: Additional planet's mass in [Mjup]

% Output: 
    % - RandomExo: Struct containing the information of the additional
    %              exoplanet generated


Constants;                                  % Load constant values 
RandomExo.system = KnownExo(1).system;      % Asign system nam
RandomExo.smass = KnownExo(1).smass;        % Asign system mass
RandomExo.plet = 'rand';                    % Asign planet letter 'rand' for random

RandomExo.I = acos((2 * rand - 1) * 0);     % Randomly generate  (or fix to pi / 2) inclination

RandomExo.e = e;                            % Asign given eccentricity

RandomExo.om = 2 * pi * rand;               % Randomly generate arguments of periastron
RandomExo.dist = KnownExo(1).dist;          % Asign star distance
RandomExo.pmass = m;                        % Asign given planetary mass

RandomExo.RAAN = 2 * pi * rand * 0;         % Randomly generate or fix Longitude of ascending node to 0
RandomExo.M0 = 2 * pi * rand * 0;           % Randomly generate or fix Mean anomaly to 0
RandomExo.T = 0;     

RandomExo.a = a;                            % Asign given semi-major axis
RandomExo.per = 2 * pi * sqrt((RandomExo.a ^ 3) ...             
                / (G * (RandomExo.smass + RandomExo.pmass))) ;  % Calculate Random's planet Orbital Period
                       
end

