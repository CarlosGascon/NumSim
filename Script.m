%% Script
% Description: This script generates numerical (a, e) or (a, m) maps,
% depending on the option selected. The target system is specified by
% TargetList following the format {'System name', 'planet letter'}.  

TargetList = {'7 CMa', ['b']};                    % List of Targets  
Targets = ImportData(TargetList);                 % Import Targetlist data from Nasa Exoplanet Archive
option = 1;                                       % Select stability map: 1 for (a, e) maps, 2 for (a, m) maps

[Stab, a, y] = SystemStab(Targets{1}, option);    % Perform calculations

GeneratePlot(Stab, a, y)                          % Generate color map