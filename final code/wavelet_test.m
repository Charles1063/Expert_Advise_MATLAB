%%
% For blocky noise signal by using harr
% Test for soft-threshold with different levels
blocky_denoised_signals_soft = zeros(5000, 5);
blocky_losses_soft = zeros(5, 1);

% for i = 1 : 5
%     denoised_signal = wavelet_denoise(blocky_noisy_signal, 'db1', 's', i);
%     for j = 1 : 5000
%         blocky_losses_soft(i) = blocky_losses_soft(i) + (denoised_signal(j) - blocky_clean_signal(j)).^2/5000;
%     end
%     blocky_denoised_signals_soft(: , i) = denoised_signal;
% end
% 
% % Best level is 3
% 
% %%
% % Test for hard-threshold with different levels
% blocky_denoised_signals_hard = zeros(5000, 10);
% blocky_losses_hard = zeros(10);
% 
% for i = 1 : 5
%     denoised_signal = wavelet_denoise(blocky_noisy_signal, 'db1', 'h', i);
%     for j = 1 : 5000
%         blocky_losses_hard(i) = blocky_losses_hard(i) + (denoised_signal(j) - blocky_clean_signal(j)).^2/5000;
%     end
%     blocky_denoised_signals_hard( : , i) = denoised_signal;
% end
% 
% % Best level is 3
% 
% %%
% % Sym4 denoise for ecg signal
% % hard-threshold with level from 1 to 10
% 
% ecg_denoised_signals_hard = zeros(5000, 10);
% ecg_losses_hard = zeros(1, 10);
% 
% for i = 1 : 10
%     denoised_signal = wavelet_denoise(ecg_noisy_signal, 'sym4', 'h', i);
%     for j = 1 : 5000
%         ecg_losses_hard(i) = ecg_losses_hard(i) + (denoised_signal(j) - ecg_clean_signal(j)).^2/5000;
%     end
%     ecg_denoised_signals_hard( : , i) = denoised_signal;
% end
% 
% % Best level is 4
%     
% %%
% % Sym4 denoise for ecg signal
% % soft-threshold with level from 1 to 10
% 
% ecg_denoised_signals_soft = zeros(5000, 10);
% ecg_losses_soft = zeros(1, 10);
% 
% for i = 1 : 10
%     denoised_signal = wavelet_denoise(ecg_noisy_signal, 'sym4', 'h', i);
%     for j = 1 : 5000
%         ecg_losses_soft(i) = ecg_losses_soft(i) + (denoised_signal(j) - ecg_clean_signal(j)).^2/5000;
%     end
%     ecg_denoised_signals_soft( : , i) = denoised_signal;
% end

% Best level is 4
    
%%
% plot the best denoise signal

% hard-threshold for ecg signal
denoised_signal = wavelet_denoise(ecg_noisy_signal, 'sym4', 'h', 4);

figure(1)
hold on
plot(denoised_signal, 'b')
title('ecg denoised signal hard threshold sym4')
plot(ecg_clean_signal, 'r')
legend('denoised', 'clean')
hold off
xlim([0 500])
% % soft-threshold for ecg signal
denoised_signal = wavelet_denoise(blocky_noisy_signal, 'sym4', 'h', 4);
% 
figure(2)
hold on
plot(denoised_signal, 'b')
title('blocky denoised signal hard threshold using sym4')
plot(blocky_clean_signal, 'r')
legend('denoised', 'clean')
hold off
xlim([0 500])
% hard-threshold for blocky signal
denoised_signal = wavelet_denoise(blocky_noisy_signal, 'db1', 'h', 3);

figure(3)
hold on
plot(denoised_signal, 'b')
title('blocky denoised signal hard threshold using harr')
plot(blocky_clean_signal, 'r')
legend('denoised', 'clean')
hold off
xlim([0 500])
% % soft-threshold for blocky signal
denoised_signal = wavelet_denoise(ecg_noisy_signal, 'db1', 'h', 3);

figure(4)
hold on
plot(denoised_signal, 'b')
title('ecg denoised signal hard threshold using harr')
plot(ecg_clean_signal, 'r')
legend('denoised', 'clean')
hold off
xlim([0 500])

