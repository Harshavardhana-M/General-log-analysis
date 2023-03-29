function [unique_Name,unique_Value] = Param_array(param_name,param_value)
    
% To remove duplicate params; PS: A workaround had to be determined
    [unique_Name,index] = unique(param_name,'rows','legacy');
    unique_Value = param_value(index);

        indices_ATC = find(strncmp(unique_Name,"ATC_",4));
        indices_H   = find(strncmp(unique_Name,"H_",2));
        indices_INS   = find(strncmp(unique_Name,"INS_",4));
        %indices_PSC = find(strncmp(unique_Name,"PSC_",4));
        %indices_EK3 = find(strncmp(unique_Name,"EK3_",4));
        %indices_AHRS = find(strncmp(unique_Name,"AHRS_",5));
        %indices_AUTO = find(strncmp(unique_Name,"AUTO_",5));
        indices_WP = find(strncmp(unique_Name,"WP",2));
        indices_LAND = find(strncmp(unique_Name,"LAND",2));
    
    idx=[indices_ATC ;indices_H;indices_INS;indices_WP;indices_LAND];
    unique_Name=unique_Name(idx,:);
    unique_Value=unique_Value(idx);
    unique_Name=string(unique_Name)';

end