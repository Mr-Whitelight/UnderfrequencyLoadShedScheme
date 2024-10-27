%Global Variables
clear;
clc;
PerUnitBase=10000;
SystemDemand=12000;
dPl0=SystemDemand./PerUnitBase;
dPm=-0.2;
H=5;
D=1;
PL0=SystemDemand/PerUnitBase;
Dt=D*PL0;

%Frequency Change due to Generation Loss
fgl=@(t) 50.*(1+(dPm / Dt) .* (1 - exp((-Dt * (t)) / (2 * H))));
figure;
fplot (fgl,[0 60], 'b');
grid on
xticklabels({'0','10','20','30','40','50','60'})
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to Generation Loss');

% Frequency Change due to 1st stage Load Shedding
UFLSblock1st = 49
LoadShedPercent1st = 2.5
LoadShed1st = LoadShedPercent1st / 100;
dPl1 = -1*(LoadShed1st .* SystemDemand) / PerUnitBase;
t1 = ((-2 * H) / Dt) * log(1 - (Dt / dPm) * ((UFLSblock1st - 50) / 50))
Dt1 = (dPl0 - -1*dPl1) * D;
f1 =@(t) 50 .* (1 + (dPm / Dt1) .* (1 - exp((-Dt1 * (t)) / (2 * H))) + (-1*dPl1 / Dt1) .* (1 - exp((-Dt1 * (t - t1)) / (2 * H))));

figure;
fplot (fgl,[0 t1], 'g');
grid on;
hold on;
fplot (f1,[t1 60], 'r');
hold off;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 1st stage Load Shedding');

% Frequency Change due to 2nd stage Load Shedding
UFLSblock2nd = 48.8
LoadShedPercent2nd = 5.833
LoadShed2nd = LoadShedPercent2nd / 100;
dPl2 = -1*(LoadShed2nd .* SystemDemand) / PerUnitBase;
Dt2 = (dPl0 - -1*dPl1 - -1*dPl2) * D;
% Find the time corresponding to frequency 48.8 Hz
t1_inter=[0:0.001:60];
f1_inter=50 .* (1 + (dPm / Dt1) .* (1 - exp((-Dt1 * (t1_inter)) / (2 * H))) + (-1*dPl1 / Dt1) .* (1 - exp((-Dt1 * (t1_inter - t1)) / (2 * H))));
target_frequency = 48.8;
t2= interp1(f1_inter, t1_inter, target_frequency, 'linear', 'extrap')
f2 =@(t) 50 .* (1 + (dPm / Dt2) .* (1 - exp((-Dt2 * (t)) / (2 * H))) + (-1*dPl1 / Dt2) .* (1 - exp((-Dt2 * (t - t1)) / (2 * H))) + (-1*dPl2 / Dt2) .* (1 - exp((-Dt2 * (t - t2)) / (2 * H))));
figure;
fplot (fgl,[0 t1], 'g');
grid on;
hold on;
fplot (f1,[t1 t2], 'r');
fplot (f2,[t2 60], 'm');
grid on;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 2nd stage Load Shedding');

% Frequency Change due to 3rd stage Load Shedding
UFLSblock3rd = 48.6
LoadShedPercent3rd = 8.333
LoadShed3rd = LoadShedPercent3rd / 100;
dPl3 = (-1*LoadShed3rd .* SystemDemand) / PerUnitBase;
Dt3 = (dPl0 - -1*dPl1 - -1*dPl2--1*dPl3) * D;
% Find the time corresponding to frequency 48.6 Hz
target_frequency2 = 48.6;
t2_inter=[0:0.001:60];
f2_inter=50 .* (1 + (dPm / Dt2) .* (1 - exp((-Dt2 * (t2_inter)) / (2 * H))) + (-1*dPl1 / Dt2) .* (1 - exp((-Dt2 * (t2_inter - t1)) / (2 * H))) + (-1*dPl2 / Dt2) .* (1 - exp((-Dt2 * (t2_inter - t2)) / (2 * H))));
t3 = interp1(f2_inter, t2_inter, target_frequency2, 'linear', 'extrap')
f3 =@(t) 50 .* (1 + (dPm / Dt3) .* (1 - exp((-Dt3 * (t)) / (2 * H))) + (-1*dPl1 / Dt3) .* (1 - exp((-Dt3 * (t - t1)) / (2 * H))) + (-1*dPl2 / Dt3) .* (1 - exp((-Dt3 * (t - t2)) / (2 * H))) + (-1*dPl3 / Dt3) .* (1 - exp((-Dt3 * (t - t3)) / (2 * H))));
figure;
fplot (fgl,[0 t1], 'b');
grid on;
hold on;
fplot (f1,[t1 t2],'b');
fplot (f2,[t2 t3],'r');
fplot (f3,[t3 60],'b');
hold off;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 3rd stage Load Shedding');