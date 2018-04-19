clc
clear

noise_signal = load('ecg_data_noisy.txt');
clean_signal = load('ecg_data_clean.txt');

figure(1)
title('clean signal and noised signal')
plot(noise_signal)
hold on 
plot(clean_signal)

% 'h' for hard-threshold 's' for soft-threshold
sorh = 's';
sigden = cmddenoise(noise_signal,'sym4',4,sorh)';
figure(2)
plot(clean_signal);
hold on;
plot(sigden,'r','linewidth',1);
axis tight;