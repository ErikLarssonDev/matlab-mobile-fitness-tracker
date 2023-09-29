function [cumulative_dist, cumulative_steps, timeSpent] = calculateDistanceAndSteps(pos)
    % Extracting the required data from the input structures
    lat = pos.latitude;
    lon = pos.longitude;
    timestamps = pos.Timestamp; 
   
    
    earthCirc = 24901; % Circumference of the Earth in miles
    cumulative_steps = zeros(1, length(lat)); % Initialize cumulative steps array
    cumulative_dist = zeros(1, length(lat));
    % Calculate the total distance traveled and cumulative steps
    for i = 1:(length(lat) - 1)
        lat1 = lat(i);
        lat2 = lat(i + 1);
        lon1 = lon(i);
        lon2 = lon(i + 1);

        degDis = distance(lat1, lon1, lat2, lon2);
        dis = (degDis / 360) * earthCirc;
        cumulative_dist(i + 1) = cumulative_steps(i) + feetToMeters(dis);
        
        % Calculate the cumulative steps
        stride = 2.5;                % Average stride in feet
        dis_ft = dis * 5280;         % Convert distance from miles to feet
        steps = dis_ft / stride;     % Calculate the steps taken
        
        cumulative_steps(i + 1) = cumulative_steps(i) + steps;
    end
    
    % Calculate the time spent
    timeSpent = timestamps(end) - timestamps(1);
end

function meters = feetToMeters(feet)
    % Convert feet to meters
    % 1 foot is approximately 0.3048 meters
    meters = feet * 0.3048;
end
