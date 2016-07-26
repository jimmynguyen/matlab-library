function convertImageFormat(folder_path, fromFormat, toFormat)

    if fromFormat(1) ~= '.'
        fromFormat = ['.', fromFormat];
    end

    if toFormat(1) ~= '.'
        toFormat = ['.', toFormat];
    end

    directory = dir(folder_path);

    directory(cell2mat(cellfun(@(x) x(1) == '.', {directory.name}, 'UniformOutput', false))) = [];
    directory_files = directory(~[directory.isdir]);

    for ndx = 1:length(directory_files)
        file = directory_files(ndx);
        [~, file_name, file_extension] = fileparts(file.name);
        if strcmp(file_extension, fromFormat)
            img = imread(fullfile(folder_path, file.name));
            imwrite(img, fullfile(folder_path, [file_name, toFormat]));
        end
    end

    directory_folders = directory([directory.isdir]);

    for ndx = 1:length(directory_folders)
        folder = directory_folders(ndx);
        jp22jpg(fullfile(folder_path, folder.name));
    end

end