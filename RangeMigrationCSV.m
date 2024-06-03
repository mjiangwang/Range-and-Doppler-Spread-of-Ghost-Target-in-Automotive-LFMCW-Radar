%-------------------------------------------------------------------------
%Raw data analysis of range migration of ghost target for automotive radar.
%Copyright Beijing Jiaotong University 9570
% 2024.5
%-------------------------------------------------------------------------

close all
clear all
clc

filename = 'InterferenceData2.csv';
RawFrameData=csvread(filename);
rawData=reshape(RawFrameData,512*2,220);
C=3e8;
Fc=78e9;
Kr=1.25e+13;%Br/Tr;

%%
RangeSpec=fftshift(fft(rawData,[],1),1);
SampleNum=size(rawData,1);
RangeSpecVal=RangeSpec((SampleNum/2+1):end,:);% ValData
DopplerCell=1:size(RangeSpecVal,2);

figure
imagesc(1:round(SampleNum),DopplerCell,20*log10(abs(RangeSpecVal.')))
ylabel('Pulse Sequence')
xlabel('Range Bin')
axis xy

Fs=10e6;
ff=linspace(-Fs/2,Fs/2,SampleNum);
rr=ff*C./2/Kr;
RDSpec=fftshift(fft(RangeSpecVal,[],2),2);
figure
imagesc(rr((SampleNum/2+1):end),DopplerCell,20*log10(abs(RDSpec.')))
ylabel('Doppler Bin')
xlabel('Range(m)')
axis xy

RDSpec=RDSpec.';

figure
subplot(211)
plot(10*log10(abs(RDSpec(111,:))),'bo-')
hold on
plot(10*log10(abs(RDSpec(81,:))),'r-')
ylabel('Magnitude(dB)')
xlabel('Range Bin')
xlim([1 512])
legend('Real Target','Ghost Target')
subplot(212)
plot(10*log10(abs(RDSpec(:,12))),'bo-')
hold on
plot(10*log10(abs(RDSpec(:,160))),'r-')
ylabel('Magnitude(dB)')
xlabel('Doppler Bin')
xlim([1 220])
legend('Real Target','Ghost Target')



