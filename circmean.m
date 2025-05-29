function [meanhour, mu, circ_std_hours] = circmean(x)
    % Convert datetime to decimal hours
    hrs = hour(x);
    % need to fix this dependency on hour or hours

    
    % Convert hours to angles (degrees)
    angles_deg = hrs * 15;

    % Vector average
    sinsum = sum(sind(angles_deg));
    cossum = sum(cosd(angles_deg));

    % Compute mean angle (degrees), handle full circle
    mean_angle = atan2d(sinsum, cossum);
    if mean_angle < 0
        mean_angle = mean_angle + 360;
    end

    % Convert mean angle to hours
    mu = mean_angle / 15;  % Decimal hour
    meanhour = duration(mu, 0, 0, 'Format', 'hh:mm');

    % Compute circular standard deviation
    R = sqrt((sinsum/numel(hrs))^2 + (cossum/numel(hrs))^2);
    circ_std = sqrt(-2 * log(R));  % In radians
    circ_std_hours = circ_std * (12 / pi);  % Convert to hours
end
