function [x,D,D2] = deriv_fd4(N)

%%%%%%%  SECOND DERIV

%%% interior of matrix
D2 = diag(-30*ones(N,1))+  diag(16*ones(N-1,1),1)+  diag(16*ones(N-1,1),-1)...
    +  diag(-1*ones(N-2,1),2)+  diag(-1*ones(N-2,1),-2);

%%% first two rows
D2(1,:) = 0;
D2(2,:) = 0;
D2(1,1:6) = [45 -154 214 -156 61 -10];
D2(2,1:6) = [10 -15 -4 14 -6 1];

%%% last two rows
D2(N,:) = fliplr(D2(1,:));
D2(N-1,:) = fliplr(D2(2,:));
D2 = D2/12;  

dx = 1/(N-1);
x = linspace(0,1,N)';
D2 = D2./dx^2;

%%%%%%%  FIRST DERIV
D = zeros(N,N);
D=  diag(8*ones(N-1,1),1)-  diag(8*ones(N-1,1),-1)...
    -  diag(1*ones(N-2,1),2)+  diag(1*ones(N-2,1),-2);

%%% first two rows
D(1,:) = 0;
D(1,1:5) = [-25 48 -36 16 -3];
D(2,:) = 0;
D(2,1:5) = [-3 -10  18 -6 1];

%%% last two rows. 
D(N,:)   = -fliplr(D(1,:));
D(N-1,:) = -fliplr(D(2,:));


D = D/12;
D = D/dx;

 
