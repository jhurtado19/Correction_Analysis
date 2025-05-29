function [stdTOD, mTOD] = normalpeaks(y_vec, t_vec, color, linespec)
    % Step 1: Detect peaks (min 0.75 day apart)
    [pks, locs] = findpeaks(y_vec, t_vec, 'MinPeakDistance', 0.75);

    % Step 2: Filter amplitude outliers (z-score)
   % z = zscore(pks);
    %good_amp = abs(z) < 2;
    %pks = pks(good_amp);
    % locs = locs(good_amp);

    % Step 3: Compute mean time-of-day using circular statistics
    % loc_hours = timeofday(locs);  % durations (e.g., 14:23:00)
    [meanhour, mu, circ_std_hours] = circmean(locs);  % mu in decimal hours
    mTOD = meanhour;

    % Step 4: Filter time-of-day outliers (±3 hours from mean)
    peak_time_hours = hour(locs);  % decimal hours
    hour_diff = mod(peak_time_hours - mu + 12, 24) - 12;
    good_time = abs(hour_diff) <= 3;

    % Apply final mask
    filtered_hours = peak_time_hours(good_time);

    % Step 5: Fit normal distribution to filtered peak hours
    mu_final = hours(meanhour);
    sigma = circ_std_hours;
    stdTOD = sigma;

    
    % Create x-axis: hours centered on mu_final, wrap around 0–24
    x = linspace(0, 36, 1000); % 0 to 36 hours
    y = normpdf(x, mu_final, sigma);  % Wrap x for correct normal shape

    % Convert x to duration for plotting
    x_duration = duration(0, 0, x * 3600); % Convert hours to seconds and then to duration

    % Plot normal distribution
    plot(x_duration, y, 'LineWidth', 2, 'Color', color); hold on;
    
    % Annotate the mean with a red dashed line
    xline(mTOD, '--', char(mTOD), ...
        'Color', color, ...
        'LineWidth', 2, ...
        'LabelOrientation', 'aligned', ...
        'FontName', 'Arial', ...
        'FontSize', 18);

     % Configure axis
    title('Normal Distribution of Peak Times', 'FontName', 'Arial', 'FontSize', 18);
    xlabel('Time of Day', 'FontName', 'Arial', 'FontSize', 18);
    ylabel('Probability Density', 'FontName', 'Arial', 'FontSize', 18);
    set(gca, 'FontName', 'Arial', 'FontSize', 18);
    set(gca, 'TickLength', [0 0]);  % ← hides tick marks, keeps labels

    max_hours = 36; % Maximum number of hours

    labels = cell(1, max_hours + 1);
    for i = 0:max_hours
        labels{i + 1} = datestr(datenum('00:00', 'HH:MM') + i/24, 'HH:MM');
    end
    xticks(duration(0, 0, (0:max_hours) * 3600));
    xticklabels(labels);

    % Display results
    disp(['Parameter: ', inputname(1)]);
    disp(['Mean Peak Hour: ', char(meanhour)]);
    disp(['Circ Std Dev (hrs): ', num2str(circ_std_hours)]);
end
