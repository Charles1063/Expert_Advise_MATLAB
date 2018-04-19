clear
clc

% load data
x = load('ecg_data_noisy.txt');
clean_signal = load('ecg_data_clean.txt');

N = 512;

x = x(1:N);
clean_signal = clean_signal(1:N);

% set the window size
R = 128;
% STFT
Y = my_stft(x,R);
% SET the threshold 
Threshold = 4;
%% hard_threshold
% k = abs(Y) < Threshold;
% Y(k) = 0;
%% Soft_threshold
Y = wthresh(Y,'s',Threshold);
% inverse STFT
y = my_istft(Y);
y = y(1:N);

figure(1)
plot(y)
hold on 
% plot(x)
% hold on
plot(clean_signal)