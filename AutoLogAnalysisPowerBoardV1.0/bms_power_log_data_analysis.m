function [bms_data_table, error_table, power_error_code_table, bms_data_array, info_data_table] = bms_power_log_data_analysis(filepath)

load bms_setup_data_table.mat info_data_table

info_data_table.LowerLimit(24:25) = 0;
info_data_table.UpperLimit(24:25) = 9999;
info_data_table.LowerLimit(37) = 0;
info_data_table.UpperLimit(37) = 9999;


%% Clear temporary variables
clear opts

opts = delimitedTextImportOptions("NumVariables", 55);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["hh", "mm", "ss", "ms", regexprep(info_data_table.Name, ' ', '_')'];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

bms_data_temp = readtable(filepath, opts);

bms_data_array = table2array(bms_data_temp);

bms_data_array(bms_data_array==-1) = nan;

bms_data_table = array2table(bms_data_array,"VariableNames",opts.VariableNames);


clear opts bms_data_temp

%%
temp = bsxfun(@rdivide, table2array(bms_data_table(:,5:55)), info_data_table.Divisor');

errors_Indices = bsxfun(@gt, temp, info_data_table.UpperLimit') | bsxfun(@lt, temp, info_data_table.LowerLimit');
    
%errors_values = temp.*errors_Indices; %table containing reading going above or below the limits

%Error Count

info_data_table.Error_Count = sum(errors_Indices,1)';

info_data_table.mean = mean(bms_data_array(:,5:55), 'omitnan')';

info_data_table.std = std(bms_data_array(:,5:55), 'omitnan')';

info_data_table.max = max(bms_data_array(:,5:55),[], 'omitnan')';

info_data_table.min = min(bms_data_array(:,5:55),[], 'omitnan')';

error_variable = find(info_data_table.Error_Count~=0);

total_error_count = sum(errors_Indices, 'all');
error_name = "";
upper_limit = size(1,total_error_count);
lower_limit = size(1,total_error_count);
units = "";
time = zeros(3,total_error_count);
error_value =size(1,total_error_count);
millis_time =size(1,total_error_count);

count = 1;

errors_Indices_incl_comm = errors_Indices | isnan(bms_data_array(:,5:55));
error_rows = find(sum(errors_Indices_incl_comm, 2));
error_code_bms = bit2int(errors_Indices_incl_comm(error_rows,1:16)',16,false)';
error_code_mid = bit2int(errors_Indices_incl_comm(error_rows,17:39)',23,false)';
error_code_top = bit2int(errors_Indices_incl_comm(error_rows,40:51)',12,false)';
comm_error_indices = isnan(bms_data_array(error_rows,5:55));
comm_errors_number = bit2int(logical([sum(comm_error_indices(:,1:16),2), ...
    sum(comm_error_indices(:,17:39),2), ...
    sum(comm_error_indices(:,40:51),2)]'), 3)';

comm_errors = converCommEnum2str(comm_errors_number);

power_error_code_table = table( error_code_bms, error_code_mid,...
    error_code_top, comm_errors', 'VariableNames',{'error_code_bms',...
    'error_code_mid', 'error_code_top', 'Communication Status'});

power_error_code_table = [power_error_code_table, bms_data_table(error_rows,:)];
comm_failure_mark = power_error_code_table.("Communication Status")~="Communication Healthy";
for i = 1:size(error_variable,1)
figure('Name', strcat("BMS_LOG_",info_data_table.Name(error_variable(i))),'NumberTitle','off');
plot(bms_data_table.ms,bms_data_array(:,error_variable(i)+4)/info_data_table.Divisor(error_variable(i)));
hold on
yline(info_data_table.UpperLimit(error_variable(i)));
yline(info_data_table.LowerLimit(error_variable(i)));
if isempty(comm_failure_mark)
xline(power_error_code_table.ms(comm_failure_mark, "Color",'red'));
end
xlabel('Time (ms)') 
ylabel(info_data_table.Unit(error_variable(i))); 
exceeded_values = find(errors_Indices(:,error_variable(i))~=0);
plot(bms_data_table.ms(exceeded_values),...
bms_data_array(exceeded_values,error_variable(i)+4)/info_data_table.Divisor(error_variable(i)), 'o')
for k = 1:size(exceeded_values,1)
error_name(count) = strcat("Error ", info_data_table.Name(error_variable(i)));
upper_limit(count) = info_data_table.UpperLimit(error_variable(i));
lower_limit(count) = info_data_table.LowerLimit(error_variable(i));
units(count) = info_data_table.Unit(error_variable(i));
time(:,count) = [bms_data_table.hh(exceeded_values(k)),bms_data_table.mm(exceeded_values(k)),bms_data_table.ss(exceeded_values(k))];
error_value(count) = bms_data_array(exceeded_values(k),error_variable(i)+4)/info_data_table.Divisor(error_variable(i));
millis_time(count) = bms_data_table.ms(exceeded_values(k));
count = count+1; 
end
end

error_table = table(error_name', duration(time'), millis_time', error_value', units', upper_limit', lower_limit',...
    'VariableNames',{'error_name', 'duration', 'millis_time', 'error_value', 'units', 'upper_limit', 'lower_limit'});

end
