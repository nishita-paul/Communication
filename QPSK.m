% QPSK MODULATION AND BER 
clc; clear all; close all;
N=10^6; % Number of bits transmited
SNRdB= -10:1:15; % SNR for simulation
SNRlin=10.^(SNRdB/10);
BER = zeros(1,length(SNRlin));% simulated BER
b1 = rand(1,N) > 0.5;
b2 = rand(1,N) > 0.5;
% QPSK symbol mapping
I = (2*b1) - 1;
Q = (2*b2) - 1;
S = I + 1j*Q; 
N0 = 1./SNRlin; % Variance
for k = 1:length(SNRdB)
    
    noise = sqrt(N0(k)/2)*(randn(1,N) + 1j*randn(1,N)); % AWGN noise
    
    sig_Rx = S + noise; % Recived signal
    
    % For BER calculation
    sig_I = real(sig_Rx); % I component
    sig_Q = imag(sig_Rx); % Q component
    
    bld_I = sig_I > 0; % I decision 
    bld_Q = sig_Q > 0; % Q decision
    
    b1_error = (bld_I ~= b1); % Inphase bit error
    b2_error = (bld_Q ~= b2); % Quadrature bit error
    
    Error_bit = sum(b1_error) + sum(b2_error); % Total bit error
    BER(k) = sum(Error_bit)/(2*N); % Simulated BER
end
BER_theo = 2*qfunc(sqrt(2*SNRlin)); % Theoretical BER 

semilogy(SNRdB, BER_theo)  
hold on
semilogy(SNRdB, BER,'*')
xlabel('SNR[dB]')                                    
ylabel('Bit Error Rate');                                         
legend('Theoretical', 'Simulated');
title(['Probability of Bit Error for QPSK Modulation']);
grid on;
hold off;
