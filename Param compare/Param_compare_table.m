clear 
clc
% Open the folder where all the concerend .mat files have been placed 
files = dir('*.mat');
param_Matrix=string([numel(files)+1,200]);
for i = 1:numel(files)
    % clear all variables expect pre_param, files, i and param_Matrix 
    clearvars -except pre_param files param_Matrix i; 
    load(files(i).name);
    % User defined function to extract required data from PARM variable
    [unique_Name,unique_Value] = Param_array(PARM.Name,PARM.Value);
    param_Matrix(1+i,1)= string(files(i).name);
        if i==1 %reference flight log
            param_Matrix(2,2:length(unique_Name)+1)= unique_Value;
        else
            curr_param=unique_Value; %remaining flight logs
            % User defined function to compare the params of two logs
            differences = compareArrays(pre_param, curr_param);
            param_Matrix(i+1,2:length(unique_Name)+1)= differences;
        end
            
    pre_param=unique_Value;
    
end
%write headings of the matrix with parameter names
param_Matrix(1,2:length(unique_Name)+1)= unique_Name;
clearvars -except pre_param files param_Matrix i
%export the matrix as a spreadsheet file
writematrix(param_Matrix,'MEGAlphaparam.xlsx','Sheet',1)

