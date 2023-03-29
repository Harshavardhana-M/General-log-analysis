
figure
plot((10^-6)*double(ATT.TimeUS),double(ATT.DesYaw),'LineWidth',2)
hold on;plot((10^-6)*double(ATT.TimeUS),double(ATT.Yaw),'LineWidth',2)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C4-1140),'LineWidth',2)

xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Attitude (deg)','FontSize',22,'FontWeight','bold');
legend({'Desired Yaw','Yaw','RC Input'},'FontSize',14);
title(sprintf('%s', filename),'FontSize',26,'FontWeight','bold');
fontname(gcf,"aakar")
grid on;


