% CSV2CELL Read csv file into cell array
%   arr = csv2cell(fileName)
%   arr = csv2cell(fileName,delimiter)
%
%   Input(s):
%       fileName (char)
%           - name of .csv file you want to read from
%       delimiter (char)
%           - (optional) delimiter used in the file. The default delimiter is a comma
%
%   Output(s)
%       arr (cell)
%           - cell array containing the contents of the .csv file
%
%   @author: Jimmy Nguyen
function arr = csv2cell(fileName, varargin)

    delimiter = ',';

    if nargin == 2
        delimiter = varargin{1};
    elseif nargin > 2
        error('Too many inputs');
    end

    fh = fopen(fileName);

    line = fgetl(fh);

    arr = [];

    while ischar(line)

        row = {};

        delimiterIndices = find(line==delimiter);

        if isempty(delimiterIndices)

            content = line;
            row = [row, {formatContent(content)}];

        else
            content = line(1:(delimiterIndices(1)-1));

            row = [row, {formatContent(content)}];

            for ndx = 2:length(delimiterIndices)

                content = line((delimiterIndices(ndx-1)+1):(delimiterIndices(ndx)-1));

                row = [row, {formatContent(content)}];

            end

            if delimiterIndices(end) < length(line)

                content = line(delimiterIndices(end)+1:end);

                row = [row, {formatContent(content)}];

            end

            if length(row) < size(arr,2)

                row{size(arr,2)} = [];

            end

        end

        arr = [arr; row];

        line = fgetl(fh);

    end

    fclose(fh);

end

% FORMATCONTENT Converts content to double
%   content = formatContent(content)
%
%   @author: Jimmy Nguyen
function content = formatContent(content)

    if all(content >= '0' & content <= '9' | content == '.')

        content = str2num(content);

    end

end
