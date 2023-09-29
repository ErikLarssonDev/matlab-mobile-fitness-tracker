function cumulative_calories = estimateCaloriesBurned(weight_kg, duration_min, speed_data)
    % estimateCaloriesBurned Estimates the cumulative calories burned.
    %
    %   cumulative_calories = estimateCaloriesBurned(weight_kg, duration_min, speed_data)
    %
    %   Inputs:
    %       weight_kg : Weight of the individual in kilograms.
    %       duration_min : Duration of the workout in minutes.
    %       speed_data : Array containing speed data in m/s.
    %
    %   Output:
    %       cumulative_calories : Vector of cumulative estimated calories burned during the workout.
    
    % Validate the inputs
    if ~isnumeric(weight_kg) || ~isscalar(weight_kg) || weight_kg <= 0
        error('Weight should be a positive scalar value');
    end
    
    if ~isnumeric(duration_min) || ~isscalar(duration_min) || duration_min <= 0
        error('Duration should be a positive scalar value');
    end
    
    if ~isnumeric(speed_data) || isempty(speed_data) || any(speed_data < 0)
        error('Speed data should be a non-empty numeric array with non-negative values');
    end
    
    % Initializing activity_MET array
    activity_MET = zeros(size(speed_data));
    
    % Classifying activity and estimating MET based on speed
    for i = 1:length(speed_data)
        if speed_data(i) < 2.5
            activity_MET(i) = 3.0; % Walking
        else
            activity_MET(i) = 7.0; % Running
        end
    end
    
     % Calculate the duration for each speed data point
    duration_per_data_point = duration_min / length(speed_data);
    
    % Estimate calories burned per minute
    calories_per_min = activity_MET * weight_kg * 3.5 / 200;
    
    % Calculate cumulative calories over the workout duration
    cumulative_calories = cumsum(calories_per_min) * duration_per_data_point;
end