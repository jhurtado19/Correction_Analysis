function [stdTOD, mTOD] = testnormalpeaks(y_vec, t_vec, color, linespec)
    % Step 1: Detect peaks (min 0.75 day apart)
    [pks, locs] = findpeaks(y_vec, t_vec, 'MinPeakDistance', 0.75);

    % Step 2: Compute mean time-of-day using circular statistics
    [meanhour, mu, circ_std_hours] = circmean(locs);  % mu in decimal hours
    mTOD = meanhour;

    % Step 3: Filter time-of-day outliers (±3 hours from mean)
    peak_time_hours = hour(locs) + minute(locs)/60 + second(locs)/3600;
    hour_diff = mod(peak_time_hours - mu + 12, 24) - 12;
    good_time = abs(hour_diff) <= 3;
    filtered_hours = peak_time_hours(good_time);

    % Step 4: Fit normal distribution to filtered peak hours
    mu_final = hours(meanhour);
    sigma = circ_std_hours;
    stdTOD = sigma;

    % Step 5: Create and plot the normal distribution
    max_hours = 30;  % Display range up to 30 hours
    x = linspace(0, max_hours, 1000);
    y = normpdf(x, mu_final, sigma);

    x_duration = duration(0, 0, x * 3600); % hours → seconds → duration

    % Plot normal distribution
    plot(x_duration, y, 'LineWidth', 2, 'Color', color); hold on;

    % Annotate the mean with a vertical dashed line in same color
    xline(mTOD, '--', char(mTOD), ...
        'Color', color, ...
        'LineWidth', 2, ...
        'LabelOrientation', 'aligned', ...
        'FontName', 'Arial', ...
        'FontSize', 18);

    % Set tick labels from 00:00 to max_hours
    labels = cell(1, max_hours + 1);
    for i = 0:max_hours
        labels{i + 1} = datestr(datenum('00:00', 'HH:MM') + i/24, 'HH:MM');
    end
    xticks(duration(0, 0, (0:max_hours) * 3600));
    xticklabels(labels);

    % Configure axis
    title('Normal Distribution of Peak Times', 'FontName', 'Arial', 'FontSize', 18);
    xlabel('Time of Day', 'FontName', 'Arial', 'FontSize', 18);
    ylabel('Probability Density', 'FontName', 'Arial', 'FontSize', 18);
    set(gca, 'FontName', 'Arial', 'FontSize', 18);

    % Display results
    disp(['Parameter: ', inputname(1)]);
    disp(['Mean Peak Hour: ', char(meanhour)]);
    disp(['Circ Std Dev (hrs): ', num2str(circ_std_hours)]);
end
