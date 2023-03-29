clear all
close all
clc
[file,path] = uigetfile("*.txt",'Select IMU log');
imu_file = fullfile(path,file);
data = importdata(imu_file);
range = 8;%in terms of g(2,4,8,16)
g = 9.8;
time = double(data(:,1))*1e-6;
time_hms = seconds(time);%time in hh:mm:ss
time_hms.Format = 'hh:mm:ss.SSS';
fs = 1/(median(diff(time)));
accx = double(data(:,2));
accx = ((2/(2^16-1)).*(accx -(-32768))-1)*range*g;%acceleration in m/s/s
accy = double(data(:,3));
accy = ((2/(2^16-1)).*(accy -(-32768))-1)*range*g;
accz = double(data(:,4));
accz = ((2/(2^16-1)).*(accz -(-32768))-1)*range*g;
accz(abs(accz(:,1))>2^15)= 0;
accz(isnan(accz))=0;

%accx = reshape([accx;zeros(208,1)],[],1024);
%accy = reshape([accy;zeros(208,1)],[],1024);
%accz = reshape([accz;zeros(208,1)],[],1024);
%% PSD
%[accx_psd_db,accx_psd_lin,accxfreq,accx_peaks,accx_peak_value,accx_inference] = sigPSD(accx,fs,time);
[accx_PSD,freq] = sigPSD1(accx,fs);
[accy_PSD,freq] = sigPSD1(accy,fs);
[accz_PSD,freq] = sigPSD1(accz,fs);

sgnl_psd_x=smooth(sqrt(accx_PSD));
sgnl_psd_y=smooth(sqrt(accy_PSD));
sgnl_psd_z=smooth(sqrt(accz_PSD));
%sgnl_psd_linear =sqrt(sgnl_PSD);
%sgnl_PSD_db = 10*log10(sgnl_PSD);
%% Plot here

plot(double(freq),double(smooth(sgnl_psd_y)),'LineWidth',1)%linear PSD
hold on;plot(double(freq),double(smooth(sgnl_psd_z)),'LineWidth',1)%linear PSD
hold on;plot(double(freq),double(smooth(sgnl_psd_x)),'LineWidth',1)%linear PSD
xlabel('Frequency(Hz)','FontSize',22,'FontWeight','bold');
ylabel('Amplitude(g/\surdHz)','FontSize',22,'FontWeight','bold');
legend({'X Axis','Y Axis','Z Axis'},'FontSize',14);
title('Accelerometer PSD (Rotor Mast)','FontSize',26,'FontWeight','bold');
%% correlation

[C,lags] = xcorr(downsample(double(sgnl_psd_x),length(accel_0.x_psd_lin)),double(accel_0.x_psd_lin),'normalized');
%plot(lags,C)
max(C)