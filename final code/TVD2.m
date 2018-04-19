clc
clear
clf

%% Set the coefficient
Nit = 100;
t = 1:500;
lambda1 = 1;
lambda2 = 50;

%% Generate the clean signal and noise signal
y =load('blocks.txt');
N = length(y);
t1 = 1:N;
% y_noise = awgn(y,10,'measured');
y_noise = load('blocks_noisy.txt');

[x_block_2,cost_block_2] = tvd_mm2(y_noise,lambda1,100);

figure(1)
plot(t1,x_block_2,t1,y)
title('block 2 degree denoising')
legend('denoised signal','clean signal')

error2 = sum((x_block_2-y).^2)