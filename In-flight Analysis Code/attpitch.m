
figure
plot((10^-6)*double(ATT.TimeUS),double(ATT.DesPitch),'LineWidth',2)
hold on;plot((10^-6)*double(ATT.TimeUS),double(ATT.Pitch),'LineWidth',2)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C2-1500),'LineWidth',2)

xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Attitude (deg)','FontSize',22,'FontWeight','bold');
legend({'Desired Pitch','Pitch','RC Input'},'FontSize',14);
title(sprintf('%s', filename),'FontSize',26,'FontWeight','bold');
fontname(gcf,"aakar")
grid on;