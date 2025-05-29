% Define multiple pairs of cleaning dates

cleaning_dates = [
    datetime('01-04-2024 15:10:17', 'InputFormat', 'MM-dd-yyyy HH:mm:ss'), datetime('01-20-2024 10:00:17', 'InputFormat', 'MM-dd-yyyy HH:mm:ss')
    datetime('01-20-2024 10:00:17', 'InputFormat', 'MM-dd-yyyy HH:mm:ss'), datetime('01-31-2024 22:20:17', 'InputFormat', 'MM-dd-yyyy HH:mm:ss')
   ];

data = cdom_corrected;
data_x = t_wql;
data_y = data;

% Loop through each pair of dates
for i = 1:size(cleaning_dates, 1)
    % Find indices of cleaning dates
    xID1 = find(data_x == cleaning_dates(i, 1));
    xID2 = find(data_x == cleaning_dates(i, 2));
    
    % Extract region between cleaning dates
    x = data_x(xID1:xID2,:);
    y = data_y(xID1:xID2,:);

    dummy_x = 1:length(x);
    
    % Strip spikes, fill holes
    
    y = fil_ol2(y);

    
    % Reinsert corrected y into data
    data_y(xID1:xID2) = y;
end

data = data_y;

plot(data_x,data_y);