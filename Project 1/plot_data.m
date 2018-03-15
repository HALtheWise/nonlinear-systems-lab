tdfread('data/cleaned/death2.tsv');
clf
hold on
plot(Time,theta1)
plot(Time,theta2)
plot(Time,x)
theta1


figure
hold on
z`yyaxis left
plot(T, X(:,1),'b-', 'LineWidth', 3)
plot(T, X(:,3),'r-', 'LineWidth', 3)
hy = ylabel('Position (rad)');
set(hy, 'FontSize', 20)
yyaxis right
plot(T, push,'k', 'LineWidth', 3)
plot(T, X(:,5),'m-', 'LineWidth', 3)
hold off
hx=xlabel('Time'); %or h=get(gca,'xlabel')
hy2=ylabel('Position (m) and Escapement Force (N)');
ht = title('Position of Clock Bobs and "Base" with Escapement');
set(ht, 'FontSize', 20)
set(hx, 'FontSize', 20) 
set(hy2, 'FontSize', 18)
%set(h,'FontWeight','bold') %bold font
legend('Clock 1', 'Clock 2', 'Escapement', 'Base')
