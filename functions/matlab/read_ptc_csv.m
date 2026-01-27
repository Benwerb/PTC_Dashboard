function sensorData = read_ptc_csv(filename)
    % READ_PTC_CSV Read PTC sensor data, skipping metadata and handling missing values
    
    % Expected column names
    expectedNames = {
        'LabviewDateTime', 'ThermistorTemp', 'BathTemp', 'BathSetPoint', ...
        'Pressure_dBar', 'MaxFlow', 'FlowRate', 'PumpVolume', ...
        'CRC', 'ID', 'DateTime', 'UTC_SECS', 'CTD_DEPTH', 'CTD_TEMP', ...
        'CTD_SALINITY', 'SAMPLE_COUNTER', 'RESET_COUNTER', 'ERROR_COUNTER', ...
        'HOUSING_TEMPERATURE', 'HOUSING_HUMIDITY', 'INPUT_VOLTAGE', ...
        'INPUT_CURRENT', 'FOOBAR_PH_VALUE', 'BACKUP_BATTERY', ...
        'VRS_VOLTS', 'VRS_STDDEV', 'VK_VOLTS', 'VK_STDDEV', ...
        'IK_AMPS', 'IB_AMPS', 'Set_temp', 'Set_pres', 'StepNum'
    };
    
    numCols = length(expectedNames);
    
    % Create import options with explicit number of variables
    opts = delimitedTextImportOptions('NumVariables', numCols);
    opts.DataLines = [25, Inf];  % Start reading from line 25 (after 24 header lines)
    opts.Delimiter = ',';
    opts.ConsecutiveDelimitersRule = 'split';
    opts.LeadingDelimitersRule = 'keep';
    opts.TrailingDelimitersRule = 'keep';
    opts.EmptyLineRule = 'read';
    opts.MissingRule = 'fill';
    opts.ImportErrorRule = 'fill';
    
    % Set variable names
    opts.VariableNames = expectedNames;
    
    % Set variable types by index
    stringCols = [1, 9, 10, 11];  % LabviewDateTime, CRC, ID, DateTime
    
    % Set all columns to double first
    opts.VariableTypes = repmat({'double'}, 1, numCols);
    
    % Then set string columns
    for idx = stringCols
        opts.VariableTypes{idx} = 'string';
    end
    
    % Set fill values
    for idx = 1:numCols
        if ismember(idx, stringCols)
            opts = setvaropts(opts, idx, 'FillValue', "");
        else
            opts = setvaropts(opts, idx, 'FillValue', NaN);
        end
    end
    
    % Read data
    sensorData = readtable(filename, opts);
end