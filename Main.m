%% Script
% Description: This script generates numerical (a, e) or (a, m) maps,
% depending on the option selected, for the target specified by TargetList. 
% Integrations are performed using the Leapfrog integrator implemented in
% the REBOUND package. For a correct set up, please read the information
% provided in the section below.

% Basic Instructions: 
% 1. Follow the set up described in the section below. 
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

GeneratePlot(Stab, a, y)                          % Generate color map. If a and/or y are logarithmically spaced, log10(a) and/or log10(y) must be used as input arrays

%% Previous Setup

% In order to run the numerical simulations in Linux, the following previous 
% steps should be followed:

% 1. Clone the NumSim repository: git clone https://github.com/CarlosGascon/NumSim.git
% 2. Clone the REBOUND repository: git clone https://github.com/hannorein/rebound.git
% 3. Enter REBOUND directory and make: cd rebound make
% 4. Exit REBOUND directory: cd ..
% 5. Create symbolic link: 	ln -s ./rebound/librebound.so ./NumSim/librebound.so
% 6. Export library Path: export LD_LIBRARY_PATH=`pwd`'/rebound/src'
% 7. Run matlab from same terminal: matlab &
% 8. Generate Matlab executable file by running GenerateMex.m
% 9. Configure simulation parameters and run Main.m

