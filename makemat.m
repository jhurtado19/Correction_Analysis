function makemat(tbl, filename)
    % Get the variable names from the table
    varNames = tbl.Properties.VariableNames;
    
    % Loop through each variable name
    for i = 1:length(varNames)
        % Get the data for the current variable
        data = tbl.(varNames{i});
        
        % Assign the data to a variable in the base workspace with the same name as the column
        assignin('base', varNames{i}, data);
    end
    
    % Save the workspace to a .mat file
    
    save(filename);


end

    