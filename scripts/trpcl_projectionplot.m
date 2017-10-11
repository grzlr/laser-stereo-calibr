clear;
 
% camera instrinsics
fx = 1399.53;
fy = fx;
cx = 1169.16;
cy = 703.221;
% fx = 1418.527;
% fy = fx;
% cx = 1184.231;
% cy = 683.486;
% fx = 1400;
% fy = fx;
% cx = 1104;
% cy = 621;
K = [fx 0 cx; 0 fy cy; 0 0 1];

% load gt points
load('../data/points.mat');

% opening point cloud file
fid = fopen('../data/pcl_tr.pcd');

% skipping the first 11 lines that make up the header of .ply or .pcd file
for i = 1 : 11
    tline = fgets(fid);
end
% reading the points
pcl_tr = fscanf(fid, '%f', [3, Inf]);
size_pcl = size(pcl_tr, 2);

% projecting the point cloud to 2D - [u v w]' 
cam1 = K * pcl_tr;

% dividing by w
for i = 1 : size_pcl
    cam2(:, i) = cam1(:, i) ./ cam1(3, i);
end

% rounding off to the nearest integer
cam3 = round(cam2);

ncam = [cam3(1,:); cam3(2,:)];
figure
imshow('left-rect-frame20-gray.png');
hold on
scatter(ncam(1,:), ncam(2,:));
