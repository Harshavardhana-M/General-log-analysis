

figure
plot((10^-6)*double(RATE.TimeUS),(double(RATE.RDes)),'LineWidth',1)
hold on;plot((10^-6)*double(RATE.TimeUS),(double(RATE.R)),'LineWidth',1)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C1-1500),'LineWidth',2)

xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Rate (deg/s)','FontSize',22,'FontWeight','bold');
legend({'Desired Roll Rate','Roll Rate','RC Input'},'FontSize',14);
title(sprintf('%s', filename),'FontSize',26,'FontWeight','bold');
fontname(gcf,"aakar")
grid on;