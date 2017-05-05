% CELL2CSV Write cell array to csv file
%   cell2csv(fileName,cellArray)
%   cell2csv(fileName,cellArray,delimiter)
%
%   Input(s):
%       fileName (char)
%           - name of .csv file you want to write to (should include .csv)
%       cellArray (cell)
%           - cell array you want to write to the .csv file
%       delimiter (char)
%           - (optional) delimiter to use in the file. The default delimiter is a comma
%
%   Output file(s):
%       .csv file
%
%   @author: Jimmy Nguyen
function cell2csv(fileName,cellArray,varargin)

    delimiter = ',';

    if nargin == 3
        delimiter = varargin{1};
    elseif nargin > 3
        error('Too many inputs');
    end

    [M,N] = size(cellArray);

    file = '';

    for m = 1:M

        fileRow = '';

        for n = 1:N

            cellValue = cellArray{m,n};

            if ischar(cellValue)

                    fileRow = [fileRow,cellValue,delimiter];

            elseif isnumeric(cellValue)

                    fileRow = [fileRow,num2str(cellValue),delimiter];

            end

        end

        file = [file,sprintf('\n'),fileRow(1:end-1)];

    end

    % remove starting new line character
    file(1) = [];

    % write csv file
    fh = fopen(fileName,'w');
    fprintf(fh,file);
    fclose(fh);

end
