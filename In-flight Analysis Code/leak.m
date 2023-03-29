
function [ILMI]= leak(Ivalue,A,t)

% To increase length of altitude array to match PIDY.I using interpolation 
tic
m=length(A);
n=length(Ivalue);
xi = (1:n)'; 
x = linspace(1,n,m); 
Altitude=interp1(x,double(A),xi);
Time=interp1(x,double(t),xi);
Vz=diff(Altitude)./diff(Time);%Vertical Velocity
toc
% Region of Interest

ILMI=mean(double(Ivalue(abs(Vz)>0.201 & abs(Vz)<0.6)));%Filter 0.201m/s sensor error and region where V < (0.4m/s+ error)
end
