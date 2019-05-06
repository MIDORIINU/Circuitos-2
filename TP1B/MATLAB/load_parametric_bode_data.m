function [Data, DataCount] = load_parametric_bode_data(file_name, ...
    prealocate_array_size, prealocate_array_count)
%LOAD_PARAMETRIC_BODE_DATA Load parametric bode data exported from LTSPICE.


if (nargin < 2)
    prealocate_array_size = 65000;
end

if (nargin < 3)
    prealocate_array_count = 3;
end


%Cargo los datos
fileID = fopen(file_name);


fprintf('Loading data...\n');

tline = fgetl(fileID); % Skip global header.

if ischar(tline)
    tline = fgetl(fileID); % Skip header.
end

NewData = zeros(prealocate_array_size, 2);
NewDataCount = 0;
Data = zeros(prealocate_array_size, 2, prealocate_array_count);
DataCount = 0;

while true
    
    end_of_file = ~ischar(tline);
    
    if ~end_of_file
        k = strfind(tline,'Step Information:'); % Check header.
        
        header_found = isequal(k, (1.0));
    else
        header_found = false;
    end
    
    
    if ~end_of_file && ~header_found
        % New value.
        
        C = textscan(tline, '%f %f,%f'); % Parse line.
        
        if ~isequal(size(C), [1 3])
            error('\n\nError: %s.\n', 'File format error');
        end
        
        NewDataCount = NewDataCount + 1;
        
        NewData(NewDataCount, :) = [C{1} complex(C{2}, C{3})];
        
    else
        % New header.
        
        if (header_found)
            fprintf('New header, starting new data array (%d).\n', ...
                DataCount + 1);
        end
        
        if NewDataCount > 0
            NewData = NewData(1:NewDataCount,:);
            
            Data = Data(1:NewDataCount,:,:);
        end
        
        if DataCount > 0
            Data(:,:,DataCount) = NewData;
        end
        
        NewData = zeros(prealocate_array_size, 2);
        
        NewDataCount = 0;
        
        if ~end_of_file
            DataCount = DataCount + 1;
        end
        
    end
    
    if ~end_of_file
        tline = fgetl(fileID); % Read line.
    else
        clear NewData NewDataCount;
        
        break;
    end
    
end


fclose(fileID);

fprintf('Data loaded.\n');

end

