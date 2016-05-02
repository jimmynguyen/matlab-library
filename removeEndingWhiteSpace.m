%% REMOVEENDINGWHITESPACE Removes trailing white space
%
%	removeEndingWhiteSpace(filename)
%
%	Input(s):
%		filename (char)
%			- name of file
%
%	Output(s):
%		NONE
%
%	Description:
%		Removes white space from the end of lines in the given file
function removeEndingWhiteSpace(filename)

	fh = fopen(filename);

	file = '';

	line = fgetl(fh);

	while ischar(line)

		file = [file sprintf('\n') deblank(line)];

		line = fgetl(fh);

	end

	fclose(fh);

	fh = fopen(filename,'w');

	fprintf(fh,'%s',file);

	fclose(fh);

end