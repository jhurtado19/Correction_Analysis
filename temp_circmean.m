y = temp;
t = t_wql;


[pks, locs] = findpeaks(y, t, 'MinPeakDistance', hours(20));

% Remove amplitude outliers
%z = zscore(pks);
%pks = pks(abs(z) < 2);
%locs = locs(abs(z) < 2);

% Now filter peaks that are far from the temporal mean
[filtered_locs, filtered_pks, meanhour, circ_std_hours] = ...
    filter_peaks_by_mean_time(locs, pks, 24);  % ±3 hours allowed

% Display results
disp(['Mean Peak Hour: ', char(meanhour)]);
disp(['Circ Std Dev (hrs): ', num2str(circ_std_hours)]);

% Plot
plot(t, y); hold on;
plot(filtered_locs, filtered_pks, 'go');
title('Cleaned Peaks Near Mean Time');
