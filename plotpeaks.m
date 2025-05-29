function [pks, locs] = plotpeaks(x, y, z)
    % Find peaks
    [pks, locs] = findpeaks(y, x, 'MinPeakDistance', z);
    [pks2, locs2] = findpeaks(-y, x, 'MinPeakDistance', z);
    pks2 = -pks2;

    % Plot data and peaks in current axes
    plot(x, y);
    hold on;
    plot(locs, pks, 'go');    % green circles for max peaks
    plot(locs2, pks2, 'ro');  % red circles for min peaks
    hold off;
end
