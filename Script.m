%% Script
% Script for the generation of numerical (a, e) or (a, m) plots

TargetList = {'7 CMa', ['b']};                    % List of Targets  
Targets = ImportData(TargetList);                 % Import Targetlist data from Nasa Exoplanet Archive
option = 1;                                       % Select stability map: 1 for (a, e), 2 for (a, m)

[Stab, a, y] = SystemStab(Targets{1}, option);    % Perform calculations

GeneratePlot(Stab, a, y)