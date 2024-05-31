%Radar Interferece signal Analysis by millimeter wave radar  @ 2024
%Range Migration and spread of ghost target due to the relative offset of chirp rate and the clock drift between two interactional
%radars
%Copy Right: Beijing Jiaotong University 9570
close all
clear all
clc

load('RawInterferenceData.mat')

PulseLength=size(RawFrameData,2);
PulseNum=size(RawFrameData,1);
InterferedPulseNum=30;
InterferedFrameData=RawFrameData;
TempFrameFFT1=fft(InterferedFrameData,[],2);
TempFrameFFT=fftshift(TempFrameFFT1,2);

figure
plot(InterferedFrameData(InterferedPulseNum,1:PulseLength/2),'r-')
hold on
plot(InterferedFrameData(PulseNum,1:PulseLength/2),'b-','Linewidth',3)
xlabel('Range Sample')
ylabel('Magnitude')
legend('With Interference','Without Interference')
xlim([1 PulseLength/2])

figure
plot(20*log10(abs(TempFrameFFT(InterferedPulseNum,(PulseLength/2+1):end))),'r-')
hold on
plot(20*log10(abs(TempFrameFFT(PulseNum,(PulseLength/2+1):end))),'b-','Linewidth',3)
xlabel('Range Spectrum')
ylabel('Magnitude(dB)')
legend('With Interference','Without Interference')
xlim([1 PulseLength/2])

figure
imagesc(20*log10(abs(TempFrameFFT(1:InterferedPulseNum,(PulseLength/2+1):end))));
xlabel('Range Spectrum')
ylabel('Pulse Sequence')
axis xy

InterferedData=(TempFrameFFT(1:InterferedPulseNum,(PulseLength/2+1):end));
DFFT2=fftshift(fft(InterferedData,[],1),1);

figure
mesh(20*log10(abs(DFFT2)));
xlabel('Range Spectrum')
ylabel('Doppler Spectrum')
zlabel('Magnitude(dB)')
axis xy


