function denoise = wavelet_denoise(noise_signal, method, threshold, level)

%{
parameters:
    noise_signal: a given signal with noise
    method: 'db1' or 'sym4'
    threshold: 's' for soft-threshold and 'h' for hard-threshold
    level: number of levels 
return:
    a denoised signal
%}

denoise = cmddenoise(noise_signal, method, level, threshold);
