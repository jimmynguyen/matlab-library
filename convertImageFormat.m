% convertImageFormat Convert file(s) from one format to another
%   convertImageFormat(src_path, dst_path)
%       - only valid if src_path and dst_path are single files
%   convertImageFormat(src_path, dst_path, to_format)
%       - if src_path is a single file, dst_path can be a single file or a
%         directory
%       - if src_path is a directory, dst_path must be a directory
%       - if dst_path is a single file and the extension does not match the
%         to_format input, the to_format will be appended to the dst_path
%   convertImageFormat(src_path, dst_path, to_format, is_recursive)
%       - if src_path is a directory and is_recursive is true, every image in
%         each subdirectory will be converted to the new format and the folder
%         structure will be maintained in the dst_path
%       - is_recursive is false by default
%   convertImageFormat(src_path, dst_path, to_format, is_recursive, copy_folder_structure)
%       - if src_path is a directory, is_recursive is true, and
%         copy_folder_structure is false, every image in each subdirectory will
%         be converted to the new format into the dst_path and prepended with
%         numbers 1, 2, etc.
%   convertImageFormat(src_path, dst_path, to_format, is_recursive, copy_folder_structure, from_format)
%       - if from_format is defined, only files in the src_path with that
%         extension will be converted
%
%   Input(s):
%       src_path (char)
%           - file or directory path to where the file(s) to be converted
%             reside(s)
%       dst_path (char)
%           - file or directory path to create the converted file(s)
%       to_format (char)
%           - (optional) format to convert files to
%       is_recursive (logical)
%           - (optional) whether or not to recurse through the subdirectories of
%             the src_path and convert images
%           - default is false. use [] to omit
%       copy_folder_structure (logical)
%           - (optional) whether or not to copy the folder structure from the
%             src_path to the dst_path
%           - default is true. use [] to omit
%       from_format (char)
%           - (optional) the format of the file(s) to be converted
%
%   Output(s):
%       none
%
%   @author: Jimmy Nguyen
%   @last_modified:
function convertImageFormat(src_path, dst_path, varargin)

    %% --------------------------------------------------
     % validate number of inputs
     % --------------------------------------------------

    if nargin > 2
        to_format = varargin{1};
    end
    if nargin > 3
        is_recursive = varargin{2};
    end
    if nargin > 4
        copy_folder_structure = varargin{3};
    end
    if nargin > 5
        from_format = varargin{4};
    end

    assert(nargin <= 6, 'Too many inputs');

    %% --------------------------------------------------
     % validate src_path
     % --------------------------------------------------

    is_src_path_an_existing_directory = exist(src_path, 'dir');
    is_src_path_an_existing_file = exist(src_path, 'file');
    % src_path must be an existing file/directory
    assert(is_src_path_an_existing_directory || is_src_path_an_existing_file, 'The src_path "%s" does not exist', src_path);
    is_src_path_a_single_file = ~is_src_path_an_existing_directory && is_src_path_an_existing_file;

    %% --------------------------------------------------
     % validate dst_path
     % --------------------------------------------------

    [dst_directory, dst_filename, dst_extension] = fileparts(dst_path);~
    is_dst_path_a_single_file = ~isempty(dst_extension);
    % if the src_path is a directory, the dst_path must be a directory
    assert(~is_src_path_a_single_file && ~is_dst_path_a_single_file, 'The dst_path must a directory if the src_path is a directory');

    %% --------------------------------------------------
     % validate to_format
     % --------------------------------------------------

    % if the dst_path is a directory, to_format must be specified
    assert(~is_dst_path_a_single_file && exist(to_format, 'var') && ~isempty(to_format), 'The to_format must be specified if the dst_path is a directory');

    % to_format must be a valid image format
    if to_format(1)

    if is_dst_path_a_single_file
        dst_path = sprintf('%s.%s')
    end


    %% validate to_format
    if length(to_format) <= 0
        error('to_format cannot be empty');
    end
    to_format = lower(to_format);
    if to_format(1) == '.'
        to_format(1) = [];
    end

    %% validate dst_path
    % if dst_path is empty, create the new files in the same location (src_path)
    if isempty(dst_path)
        dst_path = src_path;
    end
    % if dst_path doesn't exist, create it
    if ~exist(dst_path, 'dir')
        if ~exist(dst_path, 'file')
            [dst_directory, dst_filename, extension] = fileparts(dst_path);
            if isempty(extension)
                % empty extension means dst_path is a directory so create it
                mkdir(dst_path);
            else
                % not empty extension means dst_path is a file

            end
        else
    end

    from_format = lower(from_format);
    if length(from_format) > 0 && from_format(1) == '.'
        from_format(1) = [];
    end

    % check if to_format and from_format is a valid image extension
    if ~any(strcmp(possible_image_extensions, to_format))
        error('The to_format "%s" is not a valid image extension');
    end
    if ~any(strcmp(possible_image_extensions, from_format)) && ~isempty(from_format)

    directory = dir(src_path);

    directory(cell2mat(cellfun(@(x) x(1) == '.', {directory.name}, 'UniformOutput', false))) = [];
    directory_files = directory(~[directory.isdir]);

    for ndx = 1:length(directory_files)
        file = directory_files(ndx);
        [~, file_name, file_extension] = fileparts(file.name);
        if strcmp(file_extension, from_format)
            img = imread(fullfile(src_path, file.name));
            imwrite(img, fullfile(src_path, [file_name, to_format]));
        end
    end

    directory_folders = directory([directory.isdir]);

    for ndx = 1:length(directory_folders)
        folder = directory_folders(ndx);
        convertImageFormat(fullfile(src_path, folder.name));
    end

end

function isValid = isValidImageExtension(extension)
    possible_image_extensions = [imformats.ext];

    extension = lower(extension);

    isValid = ~isempty(extension) && any(strcmp)
end
