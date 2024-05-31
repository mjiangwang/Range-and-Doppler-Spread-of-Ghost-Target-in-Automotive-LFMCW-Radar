%---------------------------------------------------------
%2024.05.02  raw data analysis for interference signal
%Range Migration of ghost target due to the clock drift between two radars
%@Copy Right: Beijing Jiaotong University  9570

%---------------------------------------------------------
close all
clear all
clc
C=3e8;
Fc=78e9;
Br=640e6;    %Bandwidth
Tr=51.2e-6;  %Chirp Duration
Kr=Br/Tr;    % Chirp Rate
Fs=10e6;     %Sample Rate

%%
load RawData.mat
PulseNum=size(RawData,2);        % Pulse number 
SampleNum=size(RawData,1);       %Sample number 
ff=linspace(-Fs/2,Fs/2,SampleNum);
rr=ff*C./2/Kr;

%%
RangeSpectum=fftshift(fft(RawData,[],1),1);
RangeSpectumVal=RangeSpectum((SampleNum/2+1):end,:);
RangeCell=1:size(RangeSpectumVal,1);
DopplerCell=1:size(RangeSpectumVal,2);

figure
imagesc(RangeCell,DopplerCell,20*log10(abs(RangeSpectumVal.')))
ylabel('Pulse Sequence')
xlabel('Range Bin')
axis xy

%%
RangeDoppler=fftshift(fft(RangeSpectumVal,[],2),2);
figure
imagesc(rr((SampleNum/2+1):end),DopplerCell,20*log10(abs(RangeDoppler.')))
ylabel('Doppler Bin')
xlabel('Range(m)')
axis xy

%%
RangeDopplerSpc=RangeDoppler.';

figure
subplot(211)
plot(10*log10(abs(RangeDopplerSpc(111,:))),'bo-')
hold on
plot(10*log10(abs(RangeDopplerSpc(82,:))),'r-')
ylabel('Magnitude(dB)')
xlabel('Range Bin')
xlim([1 size(RangeSpectumVal,1)])
legend('Real Target','Ghost Target')

subplot(212)
plot(10*log10(abs(RangeDopplerSpc(:,12))),'bo-')
hold on
plot(10*log10(abs(RangeDopplerSpc(:,294))),'r-')
ylabel('Magnitude(dB)')
xlabel('Doppler Bin')
xlim([1 size(RangeSpectumVal,2)])
legend('Real Target','Ghost Target')