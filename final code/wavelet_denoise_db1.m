function [denoise,loss] = wavelet_denoise_db1(noise_signal, clean_signal)

%{
parameters:
    noise_signal: a given signal with noise
    method: 'db1' or 'sym4'
    threshold: 's' for soft-threshold and 'h' for hard-threshold
    level: number of levels 
return:
    a denoised signal
%}
N = length(noise_signal);
denoise = cmddenoise(noise_signal, 'db1',3, 'h');
denoise = denoise(:);
%% loss function
loss=0;
for i=1:N
    loss=loss+(denoise(i)-clean_signal(i)).^2/N;
end
