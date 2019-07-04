%% Script
% Description: This script generates numerical (a, e) or (a, m) maps,
% depending on the option selected, for the target specified by TargetList. 
% Integrations are performed using the Leapfrog integrator implemented in
% the REBOUND package. For a correct set up, please read the information
% provided in the README file.

% Use Instructions: 
% 1. Follow the set up described in the README file. 
% 2. Define Target
% 3. Select option for type of stability map
% 4. Run script

% References: 

% - [1] Rein, H. and Liu, S.-F. (2012). Rebound: an open-source multi-purpose n-body code for collisional dynamics.
%       Astronomy & Astrophysics, 537:A128.

% TargetList struct must be defined as : {'System Name', 'planet letter'}
TargetList = {'HD 154345', ['b']};                % Specify target for simulation
Targets = ImportData(TargetList);                 % Import Targetlist data from Nasa Exoplanet Archive
option = 1;                                       % Select stability map: 1 for (a, e) maps, 2 for (a, m) maps

[Stab, a, y] = SystemStab(Targets{1}, option);    % Perform calculations

GeneratePlot(Stab, a, y)                          % Generate color map