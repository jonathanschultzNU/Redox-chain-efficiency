function IN = load_input_data(filename)
    inputTable = readtable(filename, 'ReadVariableNames', false, 'Format', '%s%s');
    inputCell = table2cell(inputTable);

    % Load input variables into the IN structure
    for i = 1:size(inputCell, 1)
        variableName = inputCell{i, 1};  % Variable name
        variableValue = inputCell{i, 2}; % Variable value

        % Convert the variableValue if it represents a number
        numValue = str2double(variableValue);
        if ~isnan(numValue)  % If it's a valid number, store it as numeric
            IN.(variableName) = numValue;
        else  % Otherwise, keep it as a string
            IN.(variableName) = char(variableValue);  % Convert to character array
        end

    end
end
