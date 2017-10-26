function [R, t, K, world_points_raw, image_points, origin, baseline] = read_files(data_path)

cd(data_path);

% read rotation matrix
fid = fopen('rotation_matrix.txt');
R = fscanf(fid, '%f', [3, Inf]);
R = R';
fclose(fid);

% read translation matrix
fid = fopen('translation_matrix.txt');
t = fscanf(fid, '%f', [3, Inf]);
fclose(fid);

% read camera intrinsic matrix
fid = fopen('camera_matrix.txt');
K = fscanf(fid, '%f', [3, Inf]);
K = K';
fclose(fid);

% read world points matrix
fid = fopen('world_points_raw.txt');
world_points_raw = fscanf(fid, '%f', [3, Inf]);
world_points_raw = world_points_raw';
fclose(fid);

% read image points matrix
fid = fopen('image_points.txt');
image_points = fscanf(fid, '%f', [2, Inf]);
image_points = image_points';
fclose(fid);

% read origin
fid = fopen('origin.txt');
origin = fscanf(fid, '%f', [3, Inf]);
origin = origin';
fclose(fid);

% read baseline
fid = fopen('baseline.txt');
baseline = fscanf(fid, '%f', [1, Inf]);
fclose(fid);

end