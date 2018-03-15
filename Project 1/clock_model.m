clear

% Define Initial conditions [T1,V1,T2,V2,Y,V]
x0 = [.1, 0, 0.1, .02, 0, 0];

% Define System Parameters


% Define Push
push = [];

options = odeset('MaxStep', 0.01);
[T,X] = ode45(@derivs, [0,100],x0,options);
for i = 1:length(X)
    push = [push, escapement(X(i,1),X(i,2))];
end
figure
hold on
plot(X(:,1), X(:,2),'b')
plot(X(:,3), X(:,4),'g')
plot(X(:,5), X(:,6),'r')
ylim([-x0(1)-.01,x0(1)+.01]);
xlim([-x0(1)-.01,x0(1)+.01]);
hhy = ylabel('Position (rad)');
set(hhy, 'FontSize', 20);
hhx = xlabel('Velocity (rad/s)');
set(hhx, 'FontSize', 20);
hht = title('Phase Space');
set(hht, 'FontSize', 20);
hold off
hhl = legend('Clock 1', 'Clock 2', 'Base');
set(hhl, 'FontSize', 14);


figure
hold on
yyaxis left
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


function X = derivs(t, state)
    m = .0689;
    M = .8949;
    k = .4;
    B = .9;
    b = 0.00124;
    g = 9.8;
    l = 0.335;
    mu = (m/(M+2*m));
    Gamma = B*sqrt(l/(4*g))/(M+2*m);
    gamma = b*sqrt(l/(4*g));
    Omega = k/(M+2*m);
    
    A = [0, 1, 0, 0, 0, 0;
         (1-mu)/(2*mu-1), (-2*gamma*(1-mu))/(1-2*mu), -mu/(1-2*mu), (-2*gamma*mu)/(1-2*mu), ((Omega^2)/(1-2*mu)), 2*Gamma/(1-2*mu);
         0, 0, 0, 1, 0, 0;
         mu/(2*mu-1), (2*gamma*mu)/(2*mu-1), -(mu-1)/(2*mu-1), (-2*gamma*(mu-1))/(2*mu-1), ((Omega^2)/(1-2*mu)), -2*Gamma/(2*mu-1);
         0, 0, 0, 0, 0, 1;
         -mu/(2*mu-1), (-2*gamma*mu)/(2*mu-1), -mu/(2*mu-1), (-2*gamma*mu)/(2*mu-1), (-Omega^2/(1-2*mu)), 2*Gamma/(2*mu-1)];
     
    X = A*state;
end
function escape = escapement(theta, omega)
    range_angle = 3.338;
    min_angle = 1.909;
    cent_angle = min_angle+(range_angle/2);
    if theta > - deg2rad(range_angle/2) + deg2rad(cent_angle) && theta < deg2rad(range_angle/2) + deg2rad(cent_angle) && omega > 0
        escape = .001;
    else
        escape = 0;
    end
    
end