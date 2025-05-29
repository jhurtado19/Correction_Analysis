%% Plot all peaks %%

normalpeaks(temp, t_wql, "cyan", "-b");
normalcircpeaks(trp_corrected, t_wql, "blue", "-b");
normalcircpeaks(cdom_corrected, t_wql, "green", "-b");
title("Month Peak Times")

% Legend
lgd = legend('Temp','Temp Temporal Mean','TRP', 'TRP Temporal Mean', 'CDOM', 'CDOM Temporal Mean');
set(lgd, 'Box', 'off', 'Color', 'none', 'FontName', 'Arial', 'FontSize', 18);
