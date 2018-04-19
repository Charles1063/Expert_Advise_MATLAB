
% noise_signal = load('ecg_data_noisy.txt');
% noise_signal = [noise_signal;noise_signal];
% clean_signal = load('ecg_data_clean.txt');
% clean_signal = [clean_signal;clean_signal];
[y,lost]=stft_denoise(blocky_noisy_signal,blocky_clean_signal);
% noise_signal2 = load('blocks_noisy.txt');
% noise_signal2 = [noise_signal2;noise_signal2];
% clean_signal2 = load('blocks.txt');
% clean_signal2 = [clean_signal2;clean_signal2];
[y2,~] = stft_denoise(ecg_noisy_signal,ecg_clean_signal);


figure(1);
plot(y);
hold on; 
% plot(x)
% hold on
plot(blocky_clean_signal);
ylim([-1 2]);
xlabel('N')
xlim([0 500]);
legend('denoised','clean');
title('STFT denoising (blocky signal)');

figure(2);
plot(y2);
hold on; 
% plot(x)
% hold on
plot(ecg_clean_signal);
ylim([-1 2]);
xlabel('N')
xlim([0 500]);
legend('denoised','clean');
title('STFT denoising (non-blocky signal)');