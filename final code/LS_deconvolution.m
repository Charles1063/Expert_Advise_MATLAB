clc
clear

%% Read data
x_1d = load('blocks.txt');

N = length(x_1d);
n = (0:N-1)';                               % n : discrete-time index

%% Blurring function

M = 10;
m = 0:M-1;
h = (0.8).^m;

dc_gain = sum(h);

y = conv(x_1d, h);
% n2 = 1:length(y_blurred)
% y = awgn(y_blurred,50,'measured');
% n1 = 1:length(y1)
sigma = 10;
y = y + sigma * randn(size(y)); 
%% Convolution matrix H
% Create convolution matrix H and 
% verify that H is the same as the conv() function

H = convmtx(h', N);
G = convmtx([1,-1]',N);
%% Landweber algorithm

% Initialization
xx = zeros(size(x_1d)); 

Nit = 20;   % Nit: Number of iterations
cost = zeros(1, Nit);

alpha = dc_gain^2;   % why is this the maximum eigenvalue of H'*H ?
lambda = 0.5;
for i = 1:Nit
%     xx = xx + (1/alpha) * H' * (y - H * xx);
    xx = (H'*y + (alpha*eye(N,N)-H'*H-lambda*G'*G)*xx)/alpha;
    cost(i) = sum((y - H*xx).^2);
end

err = x_1d - xx;
rmse = sqrt(mean(err.^2))

figure(1)
subplot(2,1,1)
plot(n,xx,n,x_1d)
% plot(n2,y_blurred,n1,y)
legend('xx','x original')
% plot(n,x_1d,n,a(200,:))
legend('x original','clean signal')
subplot(2,1,2)
plot(cost)
title('cost')














