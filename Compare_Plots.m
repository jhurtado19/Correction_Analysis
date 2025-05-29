%%% Plot Originals Vs Corrected %%% 

figure();
normalcircpeaks(trp, t_wql, "blue", "-b");
hold on;
normalcircpeaks(trp_corrected, t_wql, "green", "-g");
title('Tryptophan Peaks: Original vs Corrected', 'FontName', 'Arial', 'FontSize', 18);
xlabel('Time of Day', 'FontName', 'Arial', 'FontSize', 18);
ylabel('Probability Density', 'FontName', 'Arial', 'FontSize', 18);
legend('Original', 'Mean', 'Corrected', 'Corrected Mean');
set(gca, ...
    'FontName', 'Arial', ...
    'FontSize', 18, ...
    'TickLength', [0 0]);

figure();
normalcircpeaks(cdom, t_wql, "blue", "-b");
hold on;
normalcircpeaks(cdom_corrected, t_wql, "green", "-g");
title('CDOM Peaks: Original vs Corrected', 'FontName', 'Arial', 'FontSize', 18);
xlabel('Time of Day', 'FontName', 'Arial', 'FontSize', 18);
ylabel('Probability Density', 'FontName', 'Arial', 'FontSize', 18);
legend('Original', 'Mean', 'Corrected', 'Corrected Mean');
set(gca, ...
    'FontName', 'Arial', ...
    'FontSize', 18, ...
    'TickLength', [0 0]);



