function [filter_sgnl] = movavgfilt(noisy_sgnl)
%Moving Average Filter

windowSize = windowsize(noisy_sgnl);

%Moving Average Filter Actual Yaw
 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
filter_sgnl = filter(b,a,double(noisy_sgnl));

end