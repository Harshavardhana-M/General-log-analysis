function [windsize] = windowsize(sgnl)
%This function is used to calculate best window size
windowSize = 1:2:2001;
a = 1;
for k = 1 : length(windowSize)
    b= (1/windowSize(k))*ones(1,windowSize(k));
    out = filter(b,a,sgnl);
    sad(k) = sum(abs(out - sgnl));%Sum of absolute differences
end

figure
plot(windowSize, sad, 'LineWidth', 2);

%grid on;
%xlabel('Window Size');
%ylabel('SAD');

%windsize=windowSize(sad==max(sad));

index = find(sad > 0.95 * sad(end), 1, 'first'); %Taking 95% of SAD the curve flattens out
windsize = windowSize(index);

end