function [cdom_corrected, trp_corrected] = plot_corrected_signals(month_name)
    % Correction factors
    cdom_cf = -0.0080697760016334;
    trp_cf  = -0.00576053667395936;

    % Access base workspace variables
    t     = evalin('base', 't_wql');
    temp  = evalin('base', 'temp');
    cdom  = evalin('base', 'cdom');
    trp   = evalin('base', 'trp');

    % Apply corrections
    cdom_corrected = cdom ./ (1 + cdom_cf * (temp - 20));
    trp_corrected  = trp  ./ (1 + trp_cf  * (temp - 20));

    %% Plot CDOM
    figure();
    plot(t, cdom, 'b'); hold on;
    plot(t, cdom_corrected, 'g');
    title([month_name ' 2024 CDOM RFU'], 'FontName', 'Arial', 'FontSize', 18);
    legend('Original', 'Corrected');
    xlabel('Date', 'FontName', 'Arial', 'FontSize', 14);
    ylabel('RFU', 'FontName', 'Arial', 'FontSize', 14);
    set(gca, 'FontName', 'Arial', 'FontSize', 14);

    %% Plot TRP
    figure();
    plot(t, trp, 'b'); hold on;
    plot(t, trp_corrected, 'g');
    title([month_name ' 2024 TRP RFU'], 'FontName', 'Arial', 'FontSize', 18);
    legend('Original', 'Corrected');
    xlabel('Date', 'FontName', 'Arial', 'FontSize', 14);
    ylabel('RFU', 'FontName', 'Arial', 'FontSize', 14);
    set(gca, 'FontName', 'Arial', 'FontSize', 14);
end
