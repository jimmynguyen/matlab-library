% CSV2CELL Read csv file into cell array
%   arr = csv2cell(fileName)
%
%   @author: Jimmy Nguyen
function arr = csv2cell(fileName,delimiter)

	fh = fopen(fileName);

	line = fgetl(fh);

	arr = [];

	while ischar(line)

		row = {};

		delimiterIndices = find(line==delimiter);

		content = line(1:(delimiterIndices(1)-1));

		row = [row, {formatContent(content)}];

		for ndx = 2:length(delimiterIndices)

			content = line((delimiterIndices(ndx-1)+1):(delimiterIndices(ndx)-1));

			row = [row, {formatContent(content)}];

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