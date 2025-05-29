% Assume: 
% - t is a datetime vector for one month of data at regular intervals
% - y is the corresponding signal (e.g., RFU or temp)

t = t_wql;
y = temp;

% Step 1: Detect peaks
[pks, locs] = findpeaks(y, t, 'MinPeakDistance', hours(20));  % Avoid detecting multiple peaks/day

% Step 2: Remove outlier peaks using z-score
z = zscore(pks); 
good_idx = abs(z) < 2;  % Keep peaks within 2 std deviations

% Alternatively: use relative threshold to median
% threshold = 0.3 * median(pks);
% good_idx = pks > threshold;

% Apply mask
clean_pks = pks(good_idx);
clean_locs = locs(good_idx);

% Step 3: Compute circular mean using your function
[meanhour, mu, circ_std_hours] = circmean(clean_locs);

% Step 4: Display results
disp(['Mean Peak Hour: ', char(meanhour)]);
disp(['Circular Std Dev (hrs): ', num2str(circ_std_hours)]);

% Optional: Plot
figure;
plot(t, y);
hold on;
plot(clean_locs, clean_pks, 'go', 'MarkerSize', 8, 'LineWidth', 1.5);
title('Cleaned Peaks with Mean Peak Hour');
xlabel('Time');
ylabel('Signal');
grid on;
