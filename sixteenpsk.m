%16-PSK modulation
clc;
clear all;
close all;
N=10^5;
M=16
thetaMpsk=[0:M-1]*2*pi/M;
EsNodB=-10:1:10;
L=length(EsNodB);
iphat=zeros(1,N);
for k=1:L
    ipPhase=randsrc(1,N,thetaMpsk);
    s=exp(j*ipPhase);

    n=1/sqrt(2)*[randn(1,N)+j*randn(1,N)];
    y=s+10^(-EsNodB(k)/20)*n;

    opPhase=angle(y);
    opPhase(find(opPhase<0))=opPhase(find(opPhase<0))+2*pi;
    ipPhaseHat=2*pi/M*round(opPhase/(2*pi/M));
    ipPhaseHat(find(ipPhaseHat==2*pi))=0;
    nErr(k)=size(find([ipPhase-ipPhaseHat]),2);
end

simBer=nErr/N;
theoryBer=erfc(sqrt(10.^(EsNodB/10))*sin(pi/M));

semilogy(EsNodB,theoryBer,'b-o');
hold on;
semilogy(EsNodB,simBer,'r-*');
grid on
xlabel('EsNo(dB)');
ylabel('Bit Error Rate');
legend('Theory','Simulation');
title('BER vs SNR(dB) for 16 PSK');
