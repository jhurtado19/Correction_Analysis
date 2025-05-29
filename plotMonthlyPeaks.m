function plotMonthlyPeaks(monthStr)
% plotMonthlyPeaks  Plot daily peaks & troughs for a selected month in 2024
%
%   plotMonthlyPeaks('January')   % long month name
%   plotMonthlyPeaks('Jan')       % or three-letter abbreviation
%
% REQUIREMENTS
%   • Workspace variables t_wql (datetime), trp, temp, cdom (double) must
%     exist and be equal-length column vectors.
%   • Function plotpeaks(time, data, prominence) must be on the path.
%
% OUTPUT
%   Creates a figure with three stacked axes (Tryptophan, Temperature,
%   CDOM) sharing the same x-axis, each showing peaks/troughs detected with
%   a prominence threshold of 0.75.

% ------------ Input check & month parsing --------------------------------
arguments
    monthStr (1,:) char {mustBeTextScalar}
end

try          % accept "January", "Jan", any case
    monthNum = month(datetime(monthStr,'InputFormat','MMMM','Locale','en_US'));
catch        % fall back to "MMM"
    monthNum = month(datetime(monthStr,'InputFormat','MMM','Locale','en_US'));
end

if isempty(monthNum) || ~ismember(monthNum,1:12)
    error('plotMonthlyPeaks:badMonth', ...
          'Unrecognised month string: "%s".', monthStr);
end

% ------------ Retrieve data from caller workspace ------------------------
vars = {'t_wql','trp','temp','cdom'};
for k = 1:numel(vars)
    if ~evalin('caller',sprintf('exist(''%s'',''var'')',vars{k}))
        error('plotMonthlyPeaks:missingVar', ...
              'Required variable "%s" not found in caller workspace.', vars{k});
    end
end
t_wql = evalin('caller','t_wql');
trp   = evalin('caller','trp');
temp  = evalin('caller','temp');
cdom  = evalin('caller','cdom');

% ------------ Mask the chosen month (2024) -------------------------------
mask = year(t_wql) == 2024 & month(t_wql) == monthNum;
if ~any(mask)
    warning('No data found for %s 2024.', monthStr);
end
t     = t_wql(mask);
trp   = trp(mask);
temp  = temp(mask);
cdom  = cdom(mask);

% ------------ Plot -------------------------------------------------------
figure('Name',sprintf('%s 2024 Peaks',monthStr),'Color','w');
tl = tiledlayout(3,1,'TileSpacing','compact','Padding','compact');

titles = {sprintf('Tryptophan (RFU) – %s 2024',monthStr), ...
          sprintf('Water temperature (°F) – %s 2024',monthStr), ...
          sprintf('CDOM (RFU) – %s 2024',monthStr)};
ylabels = {'RFU','°F','RFU'};
dataVec = {trp,temp,cdom};

for i = 1:3
    nexttile
    plotpeaks(t, dataVec{i}, 0.75);   % <-- your custom peak-finder
    title(titles{i})
    ylabel(ylabels{i})
    grid on
end

% Shared x-axis & tick format
axs = findall(tl,'Type','Axes');
linkaxes(axs,'x')
xtickformat('dd-MMM')
xlabel(tl,'Date')

end
