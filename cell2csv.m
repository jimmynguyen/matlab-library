% CELL2CSV Write cell array to csv file
%   cell2csv(fileName,cellArray)
%
%   @author: Jimmy Nguyen
function cell2csv(fileName,cellArray)

	[M,N] = size(cellArray);

	file = '';

	for m = 1:M

		fileRow = '';

		for n = 1:N

			cellValue = cellArray{m,n};

			switch class(cellValue)

				case 'char'

					fileRow = [fileRow,cellValue,','];

				case 'double'

					fileRow = [fileRow,num2str(cellValue),','];

			end

		end

		file = [file,sprintf('\n'),fileRow];

	end

	% remove starting new line character
	file(1) = [];

	% write csv file
	fh = fopen(fileName,'w');
	fprintf(fh,file);
	fclose(fh);

end