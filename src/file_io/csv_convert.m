
% hardcoding
fid = fopen('/media/rohit/Data/dataset_dumps/stereo_dataset/zed/scene1/3/points/world.txt');

% [file_name, path_name] = uigetfile('*.*', 'specify file');
% file_path = fullfile(path_name, file_name);
% fid = fopen(file_path);

scan_data = textscan(fid, '%s %f %f %f', 'Delimiter', ',');

world_points_raw = [scan_data{2} scan_data{3} scan_data{4}];

save_dir = uigetdir('', 'specify folder to save file in');
save_path = fullfile(save_dir, 'world_points_raw.txt');

% writing the points to a file
dlmwrite(save_path, world_points_raw, 'delimiter', ' ', 'newline', 'pc', 'precision', 8);

fclose(fid);