clc 
clear all
clf

%% Load noisy and clean signal
load('ecg_noisy_signal')
load('blocky_noisy_signal')
load('blocky_clean_signal')
load('ecg_clean_signal')
%load('blocky_noisy_signal2.mat')
load('ecg_noisy_signal2.mat')
% load('noisy_signal.mat')
% load('clean_signal.mat')
%% Create noisy and clean signal with both input
noisy_signal = [ecg_noisy_signal;blocky_noisy_signal;ecg_noisy_signal;ecg_noisy_signal2];
clean_signal = [ecg_clean_signal;blocky_clean_signal;ecg_clean_signal;ecg_clean_signal];

%% Create signal with single signal
% blocky signal
% noisy_signal = [blocky_noisy_signal;blocky_noisy_signal];
% clean_signal = [blocky_clean_signal;blocky_clean_signal];

noisy_signal = [noisy_signal;noisy_signal;noisy_signal;noisy_signal];
clean_signal = [clean_signal;clean_signal;clean_signal;clean_signal];
%% Set parameters of the algorithm
% set the number of expert
N = 10;
% stepsize
eta = 1;
% initialize loss curve
loss_curve = [];
% buffer size
blocksize = 512;
% initialize the probability
p = ones(N,1)/N;
%% Set the theta coefficient matrix
% alpha = 0;
alpha_list = ones(1,10)*0.0004;
alpha_list(1) = 0;
alpha_list(2) = 4.0000e-04;
alpha_list(3) = 4.0000e-04;
alpha_list(4) = 5.0000e-04;
alpha_list(5) = 0.9933;
alpha_list(6) = 0.9928;
alpha_list(7) = 0.9912;
alpha_list(8) = 0.9921;
alpha_list(9) = 0.9921;
alpha_list(10) = 0.9921;

% alpha_list(10) = 0.9;\\\0.0001

theta = ones(N);
for i = 1:N
    theta(:,i) = alpha_list(i)/(N-1);
    theta(i,i) = 1-alpha_list(i);
end
% theta = ones(N)*alpha/(N-1);
% for i = 1:N
%     theta(i,i) = 1-alpha;
% end
%% calculate the number of blocks
numblocks = floor(length(noisy_signal)/blocksize);
% initialize the probability
total_prob = [];

for i = 1:numblocks
%     iteration_time = i
    total_prob = [total_prob,p];
%     initialization
%     input_noise = zeros(blocksize,1);
%     input_clean = zeros(blocksize,1);
%     clear stft_denoise
%     clear stft_loss_tmp
% loss = rand(5,1)*10;
    input_noise = noisy_signal((i-1)*blocksize+1:i*blocksize);
    input_clean = clean_signal((i-1)*blocksize+1:i*blocksize);

%     for expert1 STFT\

%     [stft_denoise,stft_loss_tmp] = stft_denoise(input_noise,input_clean);
%     for expert2 tvd1_1
    [tvd1_1_denoise,tvd1_1_loss_tmp] = tvd_1(input_noise,input_clean);
%     for expert3 tvd2_1
    [tvd2_1_denoise,tvd2_1_loss_tmp] = tvd_2(input_noise,input_clean);
%     for expert4 tvd1_2
    [tvd1_2_denoise,tvd1_2_loss_tmp] = tvd_1_2(input_noise,input_clean);
%     for expert5 tvd2_2
    [tvd2_2_denoise,tvd2_2_loss_tmp] = tvd_2_2(input_noise,input_clean);
%     for expert6 tvd1_3
    [tvd1_3_denoise,tvd1_3_loss_tmp] = tvd_1_3(input_noise,input_clean);
%     for expert7 tvd2_3
    [tvd2_3_denoise,tvd2_3_loss_tmp] = tvd_2_3(input_noise,input_clean);
%     for expert8 tvd1_4
    [tvd1_4_denoise,tvd1_4_loss_tmp] = tvd_1_4(input_noise,input_clean);
%     for expert9 tvd2_4
    [tvd2_4_denoise,tvd2_4_loss_tmp] = tvd_2_4(input_noise,input_clean);
%     for expert10 harr wavelet
    [harr_denoise,harr_loss_tmp] = wavelet_denoise_db1(input_noise, input_clean);
%     for expert11 sym4 wavelet
    [sym4_denoise,sym4_loss_tmp] = wavelet_denoise_sym4(input_noise, input_clean);

%% Calculate the real output
%     size(stft_denoise)
%     size(tvd1_denoise)
%     size(tvd2_denoise)
%     size(harr_denoise)
%     size(sym4_denoise)

% p(1...10): tvd1(1...4) tvd2(1...4) harr sym4
    output = p(1)*tvd1_1_denoise + p(2)*tvd1_2_denoise + p(3)*tvd1_3_denoise... 
    + p(4)*tvd1_4_denoise + p(5)*tvd2_1_denoise + p(6)*tvd2_2_denoise +... 
    p(7)*tvd2_3_denoise + p(8)*tvd2_4_denoise + p(9)*harr_denoise + p(10)*sym4_denoise;
%% Calculate the total loss
    total_loss_tmp = 0;
    for k=1:blocksize
        total_loss_tmp =total_loss_tmp + (output(k)-input_clean(k)).^2/blocksize;
    end

%% Calculate the loss
    loss = [tvd1_1_loss_tmp; tvd1_2_loss_tmp;tvd1_3_loss_tmp; tvd1_4_loss_tmp;...
        tvd2_1_loss_tmp;tvd2_2_loss_tmp;tvd2_3_loss_tmp;tvd2_4_loss_tmp;...
        harr_loss_tmp;sym4_loss_tmp];

    if i == 1
%         stft_loss(i) = stft_loss_tmp;
        tvd1_1_loss(i) = tvd1_1_loss_tmp;
        tvd1_2_loss(i) = tvd1_2_loss_tmp;
        tvd1_3_loss(i) = tvd1_3_loss_tmp;
        tvd1_4_loss(i) = tvd1_4_loss_tmp;
        tvd2_1_loss(i) = tvd2_1_loss_tmp;
        tvd2_2_loss(i) = tvd2_2_loss_tmp;
        tvd2_3_loss(i) = tvd2_3_loss_tmp;
        tvd2_4_loss(i) = tvd2_4_loss_tmp;
        harr_loss(i) = harr_loss_tmp;
        sym4_loss(i) = harr_loss_tmp;
        total_loss(i) = total_loss_tmp; 
    else
%         stft_loss(i) = stft_loss(i-1) + stft_loss_tmp;
        tvd1_1_loss(i) = tvd1_1_loss(i-1) + tvd1_1_loss_tmp;
        tvd1_2_loss(i) = tvd1_2_loss(i-1) + tvd1_2_loss_tmp;
        tvd1_3_loss(i) = tvd1_3_loss(i-1) + tvd1_3_loss_tmp;
        tvd1_4_loss(i) = tvd1_4_loss(i-1) + tvd1_4_loss_tmp;
        tvd2_1_loss(i) = tvd2_1_loss(i-1) + tvd2_1_loss_tmp;
        tvd2_2_loss(i) = tvd2_2_loss(i-1) + tvd2_2_loss_tmp;
        tvd2_3_loss(i) = tvd2_3_loss(i-1) + tvd2_3_loss_tmp;
        tvd2_4_loss(i) = tvd2_4_loss(i-1) + tvd2_4_loss_tmp;
        harr_loss(i) = harr_loss(i-1) + harr_loss_tmp;
        sym4_loss(i) = sym4_loss(i-1) + sym4_loss_tmp;
        total_loss(i) = total_loss(i-1) + total_loss_tmp;
    end
%% Update the coefficient
    coef = exp(-eta*loss);
    for j = 1:N
        p_new(j) = sum(p.*coef.*theta(:,j));
    %     for j = 1:N
    %         tmp(j) = p(j)*coef(j)*theta(i,j)
    %     end
    end
    sum1 = sum(p_new);
    p = p_new(:)/sum1;

end
% loss_curve = [loss_curve,total_loss(end)];
%% Draw the figure

figure(1)
hold on
for i = 1:N
    plot(total_prob(i,:))
end
title('weight change')
xlabel('Number of iteration')
ylabel('Weight')
legend('tvd1_1','tvd1_2','tvd1_3','tvd1_4','tvd2_1', 'tvd2_2', 'tvd2_3', 'tvd2_4','harr','sym4')

figure(2)
hold on
plot(tvd1_1_loss,'--')
plot(tvd2_1_loss)
plot(tvd1_2_loss)
plot(tvd2_2_loss)
plot(tvd1_3_loss)
plot(tvd2_3_loss)
plot(tvd1_4_loss)
plot(tvd2_4_loss)
plot(harr_loss)
plot(sym4_loss)
plot(total_loss)
title('Cumulative loss')
xlabel('Number of blocks')
ylabel('Cumulative Loss')
legend('tvd1_1','tvd1_2','tvd1_3','tvd1_4','tvd2_1', 'tvd2_2', 'tvd2_3', 'tvd2_4','harr','sym4','total')