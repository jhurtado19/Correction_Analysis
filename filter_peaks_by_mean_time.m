function [filtered_locs, filtered_pks, meanhour, circ_std_hours] = filter_peaks_by_mean_time(locs, pks, threshold_hours)
    % Check input sizes
    if length(locs) ~= length(pks)
        error('locs and pks must be the same length.');
    end

    % Compute mean hour and circular std
    [meanhour, mu, circ_std_hours] = circmean(locs);

    % Convert peak datetimes to decimal hours
    peak_hours = hour(locs) + minute(locs)/60 + second(locs)/3600;

    % Compute circular difference to mean (±12 range)
    hour_diff = mod(peak_hours - mu + 12, 24) - 12;

    % Apply threshold
    keep_idx = abs(hour_diff) <= threshold_hours;

    % Filter outputs
    filtered_locs = locs(keep_idx);
    filtered_pks = pks(keep_idx);
end
