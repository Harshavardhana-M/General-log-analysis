function [sgnl_PSD,sgnl_fft,freq] = sigPSD1(sgnl,fs)
N = length(sgnl);
freq = 0:fs/N:fs/2;
sgnl_fft = fft((length(sgnl)).*sgnl);%without hanning
%sgnl_fft = fft(hanning(length(sgnl)).*sgnl);%with hanning
sgnl_fft = sgnl_fft(1:floor(N/2)+1);
sgnl_PSD = (1/(fs*N)) * abs(sgnl_fft).^2;
sgnl_PSD(2:end-1) = 2*sgnl_PSD(2:end-1);
end
