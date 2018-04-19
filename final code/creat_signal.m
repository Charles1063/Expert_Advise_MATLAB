clc 
clear all
%% signal we can use
% ecg_clean_signal is the clean ecg signal with N = 5000
% ecg_noisy_signal is the ecg signal with noise
% blocky_clean_signal is the clean ecg signal with N = 5000
% blocky_noisy_signal is the blocky signal with noise
% clean_signal is total clean signal
% noisy_signal is total noise signal
%%
x1 = load('ecg_data_clean.txt');
x2 = load('blocks.txt');
a = max(x2);
x2 = x2/a;
x2 = upsample(x2,2);
h = [1,1];
x2 = conv(x2,h);

x1 = x1(1:500);
x2 = x2(1:500);

y1 = [x1;x1];
y2 = [x2;x2];

%% Clean signal
ecg_clean_signal = [y1;y1;y1;y1;y1];
blocky_clean_signal = [y2;y2;y2;y2;y2];

%% Noisy signal
ecg_noisy_signal = awgn(ecg_clean_signal,5,'measured');
blocky_noisy_signal = awgn(blocky_clean_signal,5,'measured');
blocky_noisy_signal2 = awgn(blocky_clean_signal,10,'measured');

%% Plot the noise signal

figure(1)
title('clean and noisy signal')

subplot(4,1,1)
plot(ecg_clean_signal)
subplot(4,1,2)
plot(ecg_noisy_signal)
subplot(4,1,3)
plot(blocky_clean_signal)
subplot(4,1,4)
plot(blocky_noisy_signal)

%% Total signal
clean_signal = [ecg_clean_signal;blocky_clean_signal];
noisy_signal = [ecg_noisy_signal;blocky_noisy_signal];
