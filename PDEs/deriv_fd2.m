function [x,D,D2] = deriv_fd2(N)

%%%%%%  SECOND DERIV %%%%%%%%

%%% interior of matrix
D2 = diag(-2*ones(N,1))+  diag(ones(N-1,1),1)+  diag(ones(N-1,1),-1);

%%% first two rows
D2(1,:) = 0;
D2(1,1:4) = [2 -5 4 -1];

%%% last two rows
D2(N,:) = fliplr(D2(1,:));

dx = 1/(N-1);
x = linspace(0,1,N)';
D2 = D2./dx^2;

%%%%%%  FIRST DERIV %%%%%%%%

D = zeros(N,N);
D =  1/2*diag(ones(N-1,1),1)-  1/2*diag(ones(N-1,1),-1);

%%% Fix the first and last rows to be one-sided
D(1,:) = 0;
D(1,1:3) = [-3/2 2 -1/2];
D(N,:) = -fliplr(D(1,:));

D = D/dx;
