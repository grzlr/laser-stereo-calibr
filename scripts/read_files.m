function [R, t, K, world_points_raw, image_points, origin, baseline] = read_files(data_path)

cd(data_path);

% read rotation matrix
fid1 = fopen('rotation_matrix.txt');
R = fscanf(fid1, '%f', [3, Inf]);
R = R';

% read translation matrix
fid2 = fopen('translation_matrix.txt');
t = fscanf(fid2, '%f', [3, Inf]);

% read camera intrinsic matrix
fid3 = fopen('camera_matrix.txt');
K = fscanf(fid3, '%f', [3, Inf]);
K = K';

% read world points matrix
fid4 = fopen('world_points_raw.txt');
world_points_raw = fscanf(fid4, '%f', [3, Inf]);
world_points_raw = world_points_raw';

% read image points matrix
fid5 = fopen('image_points.txt');
image_points = fscanf(fid5, '%f', [2, Inf]);
image_points = image_points';

% read origin
fid6 = fopen('origin.txt');
origin = fscanf(fid6, '%f', [3, Inf]);
origin = origin';

% read baseline
fid7 = fopen('baseline.txt');
baseline = fscanf(fid7, '%f', [1, Inf]);

end