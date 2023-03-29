
function [accel_0,accel_1,accel_2,gyro_0,gyro_1,gyro_2]=PSDplot(mat_file)
[accel_0,accel_1,accel_2,gyro_0,gyro_1,gyro_2 ] = isb_extract(mat_file);
accel_0.fs = mean(accel_0.smp_rate);
accel_1.fs = mean(accel_1.smp_rate);
accel_2.fs = mean(accel_2.smp_rate);
gyro_0.fs = mean(gyro_0.smp_rate);
gyro_1.fs = mean(gyro_1.smp_rate);
gyro_2.fs = mean(gyro_2.smp_rate);
% accel_1.fs = mean(accel_1.smp_rate);
% accel_2.fs = mean(accel_2.smp_rate);
% for i=1:length(time)-1
%     f_diff(i) = 1/(time(i+1)-time(i)) *1e6;
% end
%fs = max(f_diff);
%% Accelerometer 
%instance 0
[accel_0.x_psd_db,accel_0.x_psd_lin,accel_0.xfreq,accel_0.x_peaks,accel_0.x_peak_value,accel_0.x_inference] = sigPSD(accel_0.x,accel_0.fs,accel_0.timeUS);
[accel_0.y_psd_db,accel_0.y_psd_lin,accel_0.yfreq,accel_0.y_peaks,accel_0.y_peak_value,accel_0.y_inference] = sigPSD(accel_0.y,accel_0.fs,accel_0.timeUS);
[accel_0.z_psd_db,accel_0.z_psd_lin,accel_0.zfreq,accel_0.z_peaks,accel_0.z_peak_value,accel_0.z_inference] = sigPSD(accel_0.z,accel_0.fs,accel_0.timeUS);
%instanc 1
[accel_1.x_psd_db,accel_1.x_psd_lin,accel_1.xfreq,accel_1.x_peaks,accel_1.x_peak_value,accel_1.x_inference] = sigPSD(accel_1.x,accel_1.fs,accel_1.timeUS);
[accel_1.y_psd_db,accel_1.y_psd_lin,accel_1.yfreq,accel_1.y_peaks,accel_1.y_peak_value,accel_1.y_inference] = sigPSD(accel_1.y,accel_1.fs,accel_1.timeUS);
[accel_1.z_psd_db,accel_1.z_psd_lin,accel_1.zfreq,accel_1.z_peaks,accel_1.z_peak_value,accel_1.z_inference] = sigPSD(accel_1.z,accel_1.fs,accel_1.timeUS);
%instance 2
[accel_2.x_psd_db,accel_2.x_psd_lin,accel_2.xfreq,accel_2.x_peaks,accel_2.x_peak_value,accel_2.x_inference] = sigPSD(accel_2.x,accel_2.fs,accel_2.timeUS);
[accel_2.y_psd_db,accel_2.y_psd_lin,accel_2.yfreq,accel_2.y_peaks,accel_2.y_peak_value,accel_2.y_inference] = sigPSD(accel_2.y,accel_2.fs,accel_2.timeUS);
[accel_2.z_psd_db,accel_2.z_psd_lin,accel_2.zfreq,accel_2.z_peaks,accel_2.z_peak_value,accel_2.z_inference] = sigPSD(accel_2.z,accel_2.fs,accel_2.timeUS);
%% Gyro
%instance 0
[gyro_0.x_psd_db,gyro_0.x_psd_lin,gyro_0.xfreq,gyro_0.x_peaks,gyro_0.x_peak_value,gyro_0.x_inference] = sigPSD(gyro_0.x,gyro_0.fs,gyro_0.timeUS);
[gyro_0.y_psd_db,gyro_0.y_psd_lin,gyro_0.yfreq,gyro_0.y_peaks,gyro_0.y_peak_value,gyro_0.y_inference] = sigPSD(gyro_0.y,gyro_0.fs,gyro_0.timeUS);
[gyro_0.z_psd_db,gyro_0.z_psd_lin,gyro_0.zfreq,gyro_0.z_peaks,gyro_0.z_peak_value,gyro_0.z_inference] = sigPSD(gyro_0.z,gyro_0.fs,gyro_0.timeUS);
%instance 1
[gyro_1.x_psd_db,gyro_1.x_psd_lin,gyro_1.xfreq,gyro_1.x_peaks,gyro_1.x_peak_value,gyro_1.x_inference] = sigPSD(gyro_1.x,gyro_1.fs,gyro_1.timeUS);
[gyro_1.y_psd_db,gyro_1.y_psd_lin,gyro_1.yfreq,gyro_1.y_peaks,gyro_1.y_peak_value,gyro_1.y_inference] = sigPSD(gyro_1.y,gyro_1.fs,gyro_1.timeUS);
[gyro_1.z_psd_db,gyro_1.z_psd_lin,gyro_1.zfreq,gyro_1.z_peaks,gyro_1.z_peak_value,gyro_1.z_inference] = sigPSD(gyro_1.z,gyro_1.fs,gyro_1.timeUS);
%instanc 2
[gyro_2.x_psd_db,gyro_2.x_psd_lin,gyro_2.xfreq,gyro_2.x_peaks,gyro_2.x_peak_value,gyro_2.x_inference] = sigPSD(gyro_2.x,gyro_2.fs,gyro_2.timeUS);
[gyro_2.y_psd_db,gyro_2.y_psd_lin,gyro_2.yfreq,gyro_2.y_peaks,gyro_2.y_peak_value,gyro_2.y_inference] = sigPSD(gyro_2.y,gyro_2.fs,gyro_2.timeUS);
[gyro_2.z_psd_db,gyro_2.z_psd_lin,gyro_2.zfreq,gyro_2.z_peaks,gyro_2.z_peak_value,gyro_2.z_inference] = sigPSD(gyro_2.z,gyro_2.fs,gyro_2.timeUS);
% assignin("base","gyro_0",gyro_0);
% assignin("base","gyro_1",gyro_1);
% assignin("base","gyro_2",gyro_2);
% assignin("base","accel_0",accel_0);
% assignin("base","accel_1",accel_1);
% assignin('base',"accel_2",accel_2);

% %% Acclerometer plot
% figure;
% subplot(3,2,1)
% plot(accel_0.xfreq,accel_0.x_psd);
% title('Accelerometer X PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,2)
% spectrogram(accel_0.x,[],[],[],accel_0.fs,'xaxis');colorbar;
% title('Accelerometer X Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
% subplot(3,2,3)
% plot(accel_0.yfreq,accel_0.y_psd);
% title('Accelerometer Y PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,4)
% spectrogram(accel_0.y,[],[],[],accel_0.fs,'xaxis');colorbar;
% title('Accelerometer Y Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
% subplot(3,2,5)
% plot(accel_0.zfreq,accel_0.z_psd);
% title('Accelerometer Z PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,6)
% spectrogram(accel_0.z,[],[],[],accel_0.fs,'xaxis');colorbar;
% title('Accelerometer Z Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
% %% Gyro plot 
% figure;
% subplot(3,2,1)
% plot(gyro_0.xfreq,gyro_0.x_psd);
% title('Gyroscope X PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,2)
% spectrogram(gyro_0.x,[],[],[],gyro_0.fs,'xaxis');colorbar;
% title('Gyroscope X Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
% subplot(3,2,3)
% plot(gyro_0.yfreq,gyro_0.y_psd);
% title('Gyroscope Y PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,4)
% spectrogram(gyro_0.y,[],[],[],gyro_0.fs,'xaxis');colorbar;
% title('Gyroscope Y Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
% subplot(3,2,5)
% plot(gyro_0.zfreq,gyro_0.z_psd);
% title('Gyroscope Z PSD');
% xlabel('frequency(Hz)');
% ylabel('Amplitude (g^2 / Hz)');
% subplot(3,2,6)
% spectrogram(gyro_0.z,[],[],[],gyro_0.fs,'xaxis');colorbar;
% title('Gyroscope Z Spectrogram');
% xlabel('frequency(kHz)');
% ylabel('');
