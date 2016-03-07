%% SUPPRESSCODE Suppresses code for a .m file
%
%	suppressCode(filename)
%
%	Input(s):
%		filename (char)
%			- name of .m file that you want to suppress
%
%	Output(s):
%		NONE
%
%	Description:
%		Reads in .m file, suppresses code, and rewrites to that same file
function suppressMatlabCode(filename)

	fh = fopen(filename);

	line = fgetl(fh);

	file = '';

	while ischar(line)

		% trim whitespace
		trimmedLine = strtrim(line);

		% empty line
		if isempty(trimmedLine)
			% do nothing
			
		% function header
		elseif any(strfind(trimmedLine,'function') == 1)
			% do nothing

		% comments
		elseif any(strfind(trimmedLine,'%') == 1)
			% do nothing

		% already suppressed
		elseif trimmedLine(end) == ';'
			% do nothing

		% suppress
		else

			line = [line ';'];

		end

		file = [file sprintf('\n') line];

		line = fgetl(fh);

	end

	fclose(fh);

	fh = fopen(filename,'w');

	fprintf(fh,'%s',file(2:end));

	fclose(fh);

end