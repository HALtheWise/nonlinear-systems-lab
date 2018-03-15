tagDist = .396;
pivotFromTag = tagDist*0.26582;
pendulumlen = 0.335;
m = 0.068;
M = .8949+2*m;
gravity = 9.8;

%% Configuration 1

% plottitle='Configuration 1, Stabilizing from Single-Pendulum Start';
% tdfread('data/cleaned/final_light_singlestart_stabilizes1.tsv');

%% Configuration 2

plottitle='Configuration 2, Stabilizing from Single-Pendulum Start';
tdfread('data/cleaned/final_medium_singlestart_stabilizes3.tsv');
M = M+.735;

% plottitle='Configuration 2, Dying from Single-Pendulum Start';
% tdfread('data/cleaned/final_medium_singlestart_death1.tsv');
% M = M+.735;

%% Configuration 3

% plottitle='Configuration 3, Stabilizing from Single-Pendulum Start';
% tdfread('data/cleaned/final_heavy_singlestart_stabilizes1.tsv');
% theta1 = theta1(Time<75);
% theta2 = theta2(Time<75);
% x = x(Time<75);
% Time = Time(Time<75);
% M = M+1.525;

% plottitle='Configuration 3, Dying from Single-Pendulum Start';
% tdfread('data/cleaned/final_heavy_singlestart_death.tsv');
% M = M+1.525;

% plottitle='Configuration 3, Dying';
% tdfread('data/cleaned/final_heavy_death1.tsv');
% M = M+1.525;

%% Code

g = gausswin(10); % <-- this value determines the width of the smoothing window
g = g/sum(g);
g2 = gausswin(30); % <-- this value determines the width of the smoothing window
g2 = g2/sum(g2);
speed1 = gradient(theta1, Time);
speed1 = conv(speed1, g, 'same');
e1 = m .* gravity .* pendulumlen .* (1-cos(theta1)) + .5 .* m .* (speed1 .* pendulumlen) .^ 2;
e1=conv(e1,g2,'same');

speed2 = gradient(theta2, Time);
speed2 = conv(speed2, g, 'same');
e2 = m .* gravity .* pendulumlen .* (1-cos(theta2)) + .5 .* m .* (speed2 .* pendulumlen) .^ 2;
e2=conv(e2,g2,'same');

speed3 = gradient(x, Time);
speed3 = conv(speed3, g, 'same');
e3 = .5 .* M .* (speed3) .^ 2;
e3=conv(e3,g2,'same');

figure('pos',[10 10 1920 400])
hold on
yyaxis left
plot(Time, theta1,'b-', 'LineWidth', .5)
plot(Time, theta2,'r-', 'LineWidth', .5)
plot(Time, x,'g-', 'LineWidth', .5)
hy = ylabel('Bob Angle (rad)');
set(hy, 'FontSize', 20)
yyaxis right
ylim([0,2.5e-3]);
plot(Time, e1+e2+e3,'k-', 'LineWidth', 3)
plot(Time, e1,'b-', 'LineWidth', 3)
plot(Time, e2,'r-', 'LineWidth', 3)
plot(Time, e3,'g-', 'LineWidth', 3)
hold off
hx=xlabel('Time'); %or h=get(gca,'xlabel')
hy2=ylabel('Energy (J)');
ht = title(plottitle);
set(ht, 'FontSize', 20)
set(hx, 'FontSize', 20) 
set(hy2, 'FontSize', 18)
%set(h,'FontWeight','bold') %bold font
legend('Clock 1 angle', 'Clock 2 angle', 'Base position (m)', 'Total energy', 'Clock 1 energy', 'Clock 2 energy', 'Base energy')
