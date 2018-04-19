function [y,loss]=stft_denoise(x,clean_signal)
%STFT denoise function
%
%  Usage: [y,loss]=stft_denoise(filename_noisy,filename_clean)
%
%  Parameters: filename_noisy      - noisy data file
%              filename_clean      - clean data file
%              y                   - denoised signal
%              loss                - MSE loss comparing denoised and clean signals


% load data
% x = load(filename_noisy);
% clean_signal = load(filename_clean);

N=length(x);
% N1 = length(clean_signal)
% 
% clean_signal = clean_signal(1:N);

% set the window size 128 is the best
R = 128;
% STFT
Y = my_stft(x,R);
% SET the threshold 
Threshold = 7;
%% hard_threshold
 k = abs(Y) < Threshold;
 Y(k) = 0;
%% Soft_threshold
%Y = wthresh(Y,'s',Threshold);
% inverse STFT
y = my_istft(Y);
y = y(1:N)';
% y = y(:);
%% loss function
loss=0;
for i=1:N
    loss=loss+(y(i)-clean_signal(i)).^2/N;
end