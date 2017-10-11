% comparing the point cloud point differences
clear;
load('../data/points.mat');
fid1 = fopen('../data/pcl_tr.pcd');
fid2 = fopen('../data/pcl_down.pcd');

% rotation and translation matrices received from the solver
R = [-0.85682262, -0.51557884, -0.00578405; -0.06444674, 0.11821822, -0.99089408; 0.5115678, -0.8486477, -0.13451942];
t = [-0.19138781; 0.0181162; -0.07892774];

% camera instrinsics
fx = 1399.53;
fy = fx;
cx = 1169.16;
cy = 703.221;
K = [fx 0 cx; 0 fy cy; 0 0 1];
baseline = 0.120;

% constructing the transformation matrix
T = [R, t; 0 0 0 1];

% skipping the first 11 lines that make up the header of .ply or .pcd file
for i = 1 : 11
    tline1 = fgets(fid1);
    tline2 = fgets(fid2);
end

% reading the points
pcl_down = fscanf(fid2, '%f', [3, Inf]);
size_pcl = size(pcl_down, 2);
pcl_tr = fscanf(fid1, '%f', [3, Inf]);

pcl_down(1:3, :) = pcl_down(1:3, :) - origin';
mat_pcl_tr = T * [pcl_down; ones(1, size_pcl)];

pcl_differences = mat_pcl_tr(1:3, :) - pcl_tr;
scatter3(pcl_differences(1, :), pcl_differences(2, :), pcl_differences(3, :));
