function [results] = cumulativeSumPlot(dataframe, param)
    % Extract time and data from the dataframe
    time = dataframe.datetime;
    data = dataframe.(param);

    % Create a timetable
    ts = timetable(time, data);

    % Divide the table into 24-hour groups
    uniqueDays = unique(dateshift(ts.time, 'start', 'day'));

    % Initialize a cell array to hold the daily timetables
    dailyTables = cell(length(uniqueDays), 1);

    % Loop through each unique day and extract the corresponding data
    for i = 1:length(uniqueDays)
        dayStart = uniqueDays(i);
        dayEnd = dayStart + days(1) - minutes(10);
        dailyTables{i} = ts(timerange(dayStart, dayEnd, 'closed'), :);
    end
    
    dailyTables(39) = [];


    % Extract the time column from one of the days and convert it to hours
    timeColumn = dailyTables{1}.time;
    hours = hour(timeColumn) + minute(timeColumn) / 60;

    % Find the minimum length of all daily tables
    minLength = min(cellfun(@height, dailyTables));

    % Initialize an array to hold the cumulative sum
    cumulativeSum = zeros(minLength, 1);

    % Loop through each daily table, trim to the minimum length, and sum the values
    for i = 1:length(dailyTables)
        trimmedData = dailyTables{i}.data(1:minLength);
        cumulativeSum = cumulativeSum + trimmedData;
    end

    % Return the x and y values for the plot
    x = hours(1:minLength);
    y = cumulativeSum/length(dailyTables);

    results = table(x,y);
end