%% Import Alvarado Creek fluorescence data
filename = fullfile("C:\Users\jesus\Documents\MATLAB\Alvarado_Creek-main\Correction Analysis\February_2024\data_report_Feb24.csv");  % <-- or Feb24.csv

% Detect the layout automatically, then adjust what we need
opts = detectImportOptions(filename, 'Delimiter', ',');
opts.VariableNames   = ["t_wql", "trp", "cdom", "temp"];
opts = setvartype(opts, {'t_wql'}, 'datetime');  % make sure t_wql is datetime
opts = setvaropts(opts,  't_wql', ...
                         'InputFormat',   'MM-dd-yyyy HH:mm:ss', ...
                         'DatetimeFormat','preserveinput');

datareport = readtable(filename, opts);

%% (Optional) convert to timetable for easier time-series work
datareportTT = table2timetable(datareport, 'RowTimes', 't_wql');
