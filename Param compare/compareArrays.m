function differences = compareArrays(pre_param, curr_param)
    % Initialize an array of type double to store the differences
    differences = zeros(1,length(pre_param)) + NaN;

    % Iterate through each element of the first array
    for i = 1:length(pre_param)
        % Compare the current element to the corresponding element in the second array
        if pre_param(i) ~= curr_param(i)
            differences(i) = curr_param(i);
        end
    end
end
