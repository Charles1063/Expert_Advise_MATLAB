clc
clear
clf

%% Set the coefficient
Nit = 100;
t = 1:500;
lambda1 = 1;

%% Generate the clean signal and noise signal
y =load('blocks.txt');
N = length(y);
t1 = 1:N;
% y_noise = awgn(y,10,'measured');
y_noise = load('blocks_noisy.txt');

[x_block_1,cost_block_1] = tvd_mm(y_noise,lambda1,100);

figure(1)
plot(t1,x_block_1,t1,y)
title('block 1 degree denoising')
legend('denoised signal','clean signal')

error1 = sum((x_block_1-y).^2)