%% Script

TargetList = {'7 CMa', ['b']};
Targets = ImportData(TargetList);
option = 1;

[Stab, a, y] = SystemStab(Targets{1}, option);

GeneratePlot(Stab, a, y)