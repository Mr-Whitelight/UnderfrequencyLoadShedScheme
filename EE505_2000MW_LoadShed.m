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
t=0:0.001:60;

%Frequency Change due to Generation Loss
Wg=(dPm / Dt) .* (1 - exp((-Dt * (t)) / (2 * H)));
f=50.*(1+Wg);
figure;
plot(t, f);
hold on;
grid on
xticklabels({'0','10','20','30','40','50','60'})
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to Generation Loss');


% Frequency Change due to 1st stage Load Shedding
UFLSblock1st = 49;
LoadShedPercent1st = 2.4;
LoadShed1st = LoadShedPercent1st / 100;
dPl1 = -1*(LoadShed1st .* SystemDemand) / PerUnitBase;
t1 = ((-2 * H) / Dt) * log(1 - (Dt / dPm) * ((UFLSblock1st - 50) / 50));
Dt1 = (dPl0 - -1*dPl1) * D;
Wg_Dt1 = (dPm / Dt1) .* (1 - exp((-Dt1 * (t)) / (2 * H)));
Wl1_Dt1 = (-1*dPl1 / Dt1) .* (1 - exp((-Dt1 * (t - t1)) / (2 * H)));
f1 = 50 .* (1 + Wg_Dt1 + Wl1_Dt1);

% Find the time corresponding to frequency 48.8 Hz
target_frequency = 48.8;
t_target = interp1(f1, t, target_frequency, 'linear', 'extrap');
t2=t_target;

% Create the second figure
figure;
plot(t, f1); % Plot the frequency change
hold on;

% Plot the marker at the calculated time
plot(t_target, target_frequency, 'x', 'MarkerSize', 10, 'DisplayName', 'Point');

% Extend vertical and horizontal dashed lines
line([t_target t_target], ylim, 'Color', 'k', 'LineStyle', '--'); % Vertical line
line(xlim, [target_frequency target_frequency], 'Color', 'k', 'LineStyle', '--'); % Horizontal line

% Display the marker coordinates with an offset
offset_x = 1; % Offset for x-coordinate
offset_y = 0.5; % Offset for y-coordinate
text(t_target + offset_x, target_frequency + offset_y, ...
    sprintf(' (%.4f, %.4f)', t_target, target_frequency), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

grid on;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 1st stage Load Shedding');


% Frequency Change due to 2nd stage Load Shedding
UFLSblock2nd = 48.8;
LoadShedPercent2nd = 6.5;
LoadShed2nd = LoadShedPercent2nd / 100;
dPl2 = -1*(LoadShed2nd .* SystemDemand) / PerUnitBase;
Dt2 = (dPl0 - -1*dPl1 - -1*dPl2) * D;
Wg_Dt2 = (dPm / Dt2) .* (1 - exp((-Dt2 * (t)) / (2 * H)));
Wl1_Dt2 = (-1*dPl1 / Dt2) .* (1 - exp((-Dt2 * (t - t2)) / (2 * H)));
Wl2_Dt2 = (-1*dPl2 / Dt2) .* (1 - exp((-Dt2 * (t - t2)) / (2 * H)));
f2 = 50 .* (1 + Wg_Dt2 + Wl1_Dt2 + Wl2_Dt2);

% Find the time corresponding to frequency 48.6 Hz
target_frequency2 = 48.6;
t_target2 = interp1(f2, t, target_frequency2, 'linear', 'extrap');
t3=t_target2;
% t3=1.3;

% Create the third figure
figure;
plot(t, f2); % Plot the frequency change
hold on;

% Plot the marker at the calculated time
plot(t_target2, target_frequency2, 'x', 'MarkerSize', 10, 'DisplayName', 'Point');

% Extend vertical and horizontal dashed lines
line([t_target2 t_target2], ylim, 'Color', 'k', 'LineStyle', '--'); % Vertical line
line(xlim, [target_frequency2 target_frequency2], 'Color', 'k', 'LineStyle', '--'); % Horizontal line

% Display the marker coordinates with an offset Checked
offset_x_2 = 1; % Offset for x-coordinate
offset_y_2 = -0.3; % Offset for y-coordinate
text(t_target2 + offset_x_2, target_frequency2 + offset_y_2, ...
    sprintf(' (%.4f, %.4f)', t_target2, target_frequency2), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

grid on;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 2nd stage Load Shedding');



% Frequency Change due to 3rd stage Load Shedding
UFLSblock3rd = 48.6;
LoadShedPercent3rd = 7.78;
LoadShed3rd = LoadShedPercent3rd / 100;
dPl3 = (-1*LoadShed3rd .* SystemDemand) / PerUnitBase;
Dt3 = (dPl0 - -1*dPl1 - -1*dPl2--1*dPl3) * D;
Wg_Dt3 = (dPm / Dt3) .* (1 - exp((-Dt3 * (t)) / (2 * H)));
Wl1_Dt3 = (-1*dPl1 / Dt3) .* (1 - exp((-Dt3 * (t - t3)) / (2 * H)));
Wl2_Dt3 = (-1*dPl2 / Dt3) .* (1 - exp((-Dt3 * (t - t3)) / (2 * H)));
Wl3_Dt3 = (-1*dPl3 / Dt3) .* (1 - exp((-Dt3 * (t - t3)) / (2 * H)));
f3 = 50 .* (1 + Wg_Dt3 + Wl1_Dt3 + Wl2_Dt3 + Wl3_Dt3);

% Create the fouth figure
figure;
plot(t, f3); % Plot the frequency change
hold on;
grid on;
xticklabels({'0', '10', '20', '30', '40', '50', '60'});
xlabel('Time (s)');  % Label for the horizontal axis
ylabel('Frequency (Hz)');  % Label for the vertical axis
title('Frequency Change due to 3rd stage Load Shedding');