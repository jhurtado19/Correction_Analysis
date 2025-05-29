figure;

% First subplot: Tryptophan
ax1 = subplot(3,1,1);
plotpeaks(t_wql, trp, 0.75);
title('January 2024 Tryptophan RFU');
ylabel('RFU');

% Second subplot: Temperature
ax2 = subplot(3,1,2);
plotpeaks(t_wql, temp, 0.75);
title('January 2024 Temperature °F');
ylabel('°F');

% Third subplot: CDOM
ax3 = subplot(3,1,3);
plotpeaks(t_wql, cdom, 0.75);
title('January 2024 CDOM RFU');
ylabel('RFU');
xlabel('Date');

% Link x-axes
linkaxes([ax1, ax2, ax3], 'x');

hold off
