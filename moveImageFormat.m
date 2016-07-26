function moveImageFormat(src, dst, imageFormat)

    if imageFormat(1) ~= '.'
        imageFormat = ['.', imageFormat];
    end

    directory = dir(src);

    directory(cell2mat(cellfun(@(x) x(1) == '.', {directory.name}, 'UniformOutput', false))) = [];
    directory_files = directory(~[directory.isdir]);

    for ndx = 1:length(directory_files)
        file = directory_files(ndx);
        [~, file_name, file_extension] = fileparts(file.name);
        if strcmp(file_extension, imageFormat)
            if ~exist(dst, 'dir')
                mkdir(dst);
            end
            movefile(fullfile(src, file.name), dst, 'f');
        end
    end

    directory_folders = directory([directory.isdir]);

    for ndx = 1:length(directory_folders)
        folder = directory_folders(ndx);
        get_jpg_files(fullfile(src, folder.name), fullfile(dst, folder.name));
    end

end