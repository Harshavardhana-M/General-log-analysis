function [accel_0,accel_1,accel_2,gyro_0,gyro_1,gyro_2 ] = isb_extract(mat_file)
load(mat_file,"ISBD","ISBH")
[rows,cols] = size(ISBD.x);
%accel_0.x = zeros(1,rows*cols);
%%
accel_0.x = [];
accel_0.y = [];
accel_0.z = [];
accel_0.timeUS = [];
accel_0.N = [];
accel_1.x = [];
accel_1.y = [];
accel_1.z = [];
accel_1.timeUS = [];
accel_1.N = [];
accel_2.x = [];
accel_2.y = [];
accel_2.z = [];
accel_2.timeUS = [];
accel_2.N = [];
%%
gyro_0.x = [];
gyro_0.y = [];
gyro_0.z = [];
gyro_0.timeUS = [];
gyro_0.N =[];
gyro_1.x = [];
gyro_1.y = [];
gyro_1.z = [];
gyro_1.timeUS = [];
gyro_1.N =[];
gyro_2.x = [];
gyro_2.y = [];
gyro_2.z = [];
gyro_2.timeUS = [];
gyro_2.N =[];
k0=1;k1=1;k2=1;g0=1;g1=1;g2=1;
for i =1:length(ISBH.N)-1
    isbN = ISBH.N(i);
    multiplier = ISBH.mul(i);
    smp_rate = ISBH.smp_rate(1);
    start_time = double(ISBH.SampleUS(i));
    for j=1:length(ISBD.N)
        if ISBH.type(i)==0
            temp_x = double(ISBD.x(j,:))/double(multiplier);
            temp_y = double(ISBD.y(j,:))/double(multiplier);
            temp_z = double(ISBD.z(j,:))/double(multiplier);
        else
            temp_x = (double(ISBD.x(j,:))*180/pi)/double(multiplier);
            temp_y = (double(ISBD.y(j,:))*180/pi)/double(multiplier);
            temp_z = (double(ISBD.z(j,:))*180/pi)/double(multiplier);
        end
        temp_time = uint64(start_time:1e6/smp_rate:(start_time +(length(temp_x)-1)*1e6/smp_rate));
        if ISBD.N(j) == isbN
            if ISBH.type(i) == 0    
                if ISBH.instance(i) == 0
                     accel_0.x = cat(1,accel_0.x,temp_x);
                     accel_0.y = cat(1,accel_0.y,temp_y);
                     accel_0.z = cat(1,accel_0.z,temp_z);
                     accel_0.timeUS = cat(2,accel_0.timeUS,temp_time);
                     accel_0.N = cat(1,accel_0.N,ISBD.N(j));
                     accel_0.smp_rate(k0) = smp_rate;
                    k0 = k0+1;
                elseif ISBH.instance(i) == 1
                    accel_1.x = cat(1,accel_1.x,temp_x);
                    accel_1.y = cat(1,accel_1.y,temp_y);
                    accel_1.z = cat(1,accel_1.z,temp_z);
                    accel_1.timeUS = cat(2,accel_1.timeUS,temp_time);
                    accel_1.N = cat(1,accel_1.N,ISBD.N(j));
                    accel_1.smp_rate(k1) = smp_rate;
                    k1 = k1+1;
                elseif ISBH.instance(i) == 2
                    accel_2.x = cat(1,accel_2.x,temp_x);
                    accel_2.y = cat(1,accel_2.y,temp_y);
                    accel_2.z = cat(1,accel_2.z,temp_z);
                    accel_2.timeUS = cat(2,accel_2.timeUS,temp_time);
                    accel_2.N = cat(1,accel_2.N,ISBD.N(j));
                    accel_2.smp_rate(k2) = smp_rate;
                    k2 = k2+1;
                end
            elseif ISBH.type(i) == 1
                if ISBH.instance(i) == 0
                     gyro_0.x = cat(1,gyro_0.x,temp_x);
                     gyro_0.y = cat(1,gyro_0.y,temp_y);
                     gyro_0.z = cat(1,gyro_0.z,temp_z);
                     gyro_0.timeUS = cat(1,gyro_0.timeUS,temp_time);
                     gyro_0.N = cat(1,gyro_0.N,ISBD.N(j));
                     gyro_0.smp_rate(g0) = smp_rate;
                     g0 = g0+1;
                elseif ISBH.instance(i) == 1
                    gyro_1.x = cat(1,gyro_1.x,temp_x);
                    gyro_1.y = cat(1,gyro_1.y,temp_y);
                    gyro_1.z = cat(1,gyro_1.z,temp_z);
                    gyro_1.timeUS = cat(1,gyro_1.timeUS,temp_time);
                    gyro_1.N = cat(1,gyro_1.N,ISBD.N(j));
                    gyro_1.smp_rate(g1) = smp_rate;
                    g1 = g1+1;
                elseif ISBH.instance(i) == 2
                    gyro_2.x = cat(1,gyro_2.x,temp_x);
                    gyro_2.y = cat(1,gyro_2.y,temp_y);
                    gyro_2.z = cat(1,gyro_2.z,temp_z);
                    gyro_2.timeUS = cat(1,gyro_2.timeUS,temp_time);
                    gyro_2.N = cat(1,gyro_2.N,ISBD.N(j));
                    gyro_2.smp_rate(g2) = smp_rate;
                    g2 = g2+1;
                end



            end
        end
    end
end
accel_0 = sort_ffts(accel_0);
accel_1 = sort_ffts(accel_1);
accel_2 = sort_ffts(accel_2);
gyro_0 = sort_ffts(gyro_0);
gyro_1 = sort_ffts(gyro_1);
gyro_2 = sort_ffts(gyro_2);
end

function axis = sort_ffts(axis)
temp_smp_rate = axis.smp_rate;
axis.smp_rate = [];
temp_x = axis.x;
axis.x = [];
temp_y = axis.y;
axis.y = [];
temp_z = axis.z;
axis.z = [];
vals = unique(axis.N);
for i=1:length(vals)
    ids = axis.N==vals(i);
    axis.smp_rate = cat(1,axis.smp_rate,mean(temp_smp_rate(ids)));
    temp1_x = temp_x(ids,:);
    temp1_x = reshape(temp1_x.',1,[]);
    temp1_y = temp_y(ids,:);
    temp1_y = reshape(temp1_y.',1,[]);
    temp1_z = temp_z(ids,:);
    temp1_z = reshape(temp1_z.',1,[]);
    axis.x = cat(1,axis.x,temp1_x);
    axis.y = cat(1,axis.y,temp1_y);
    axis.z = cat(1,axis.z,temp1_z);
end
end