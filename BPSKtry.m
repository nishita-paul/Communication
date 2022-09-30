clc; clear all; close all;
N=10^6;
snr_db=-10:1:10;
SNR=10.^(snr_db/10)
L=length(snr_db);

%snr_range=db2pow(snr_db);

%ser_ana=qfunc(sqrt(2*snr_range));
ser_ana=0.5*erfc(sqrt(SNR));

ser_sim=zeros(1,L);
for k=1:L
    snr=SNR(k);
    noise_pow=1/snr;
    s=randsrc(1,N,[-1 1]);
    %s=randi([-1 1],1,N);
    w=1/sqrt(2)*(randn(1,N)+j*randn(1,N));
    w=sqrt(noise_pow)*w;
    y=s+w;
    y(real(y)<0)=-1;
     y(real(y)>0)=1;
     err=size(find([y- s]),2);
     ser_sim(k)=err/N;
end

semilogy(snr_db,ser_ana,'b-o');
hold on;
semilogy(snr_db,ser_sim,'-*');
hold off;
legend('Analytical','Simulation');
xlabel('SNR(dB) --->')
ylabel('BER --->')
xlim([-5 20]);