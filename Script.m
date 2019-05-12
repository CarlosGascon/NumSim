%% Script

TargetList = {'7 CMa', ['b']};
Targets = ImportData(TargetList);

[Stab, a, e] = SystemStab(Targets{1});

GeneratePlot(Stab, a, e)