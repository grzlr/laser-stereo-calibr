function [pcl5, rep_error, size_pcl, rep_image_pixels] = pcl_projection(pcl_path, R, t, K, world_points_raw, image_points, origin, baseline)

% opening the point cloud file
cd(pcl_path);
fid = fopen('pcl_raw.pcd');

% skipping the first 11/13 lines that make up the header of .ply or .pcd file
for i = 1 : 13
    tline = fgets(fid);
end

% reading the points
pcl_raw = fscanf(fid, '%f', [3, Inf]);
size_pcl = size(pcl_raw, 2);

% constructing the transformation matrix
T = [R t; 0 0 0 1];

% extracting focal length - assuming fx = fy
focal_length = K(1);

% inverting the transformation matrix for other operations
% T_inv = [R' -R' * t; 0 0 0 1];

% transposing and homogenising the world_points matrix
world_points_raw = [world_points_raw'; ones(1, size(world_points_raw, 1))];
pcl1 = [pcl_raw; ones(1, size_pcl)];

% subtracting the origin from the world_points
world_points_raw(1:3, :) = world_points_raw(1:3, :) - origin';
world_points = world_points_raw;
pcl1(1:3, :) = pcl1(1:3, :) - origin';

% transposing and homogenising the image_points matrix
image_pixels = [image_points'; ones(1, size(image_points, 1))];

% transforming the 3D laser points to the camera origin
world_points_transformed = T * world_points;
pcl2 = T * pcl1;

% calculating disparity values for each pixel
disp = zeros(1, size_pcl);
for i = 1 : size_pcl
    disp(i) = (focal_length * baseline) / pcl2(3, i);    
end

% for i = 1 : size(im_pixels, 2)
%     disp = [disp, ((focal_length * baseline) / camera_points(3, i))];
% end

% projecting transformed 3D laser points to 2D image points using K
im_pixels = K * world_points_transformed(1:3, :);
pcl3 = K * pcl2(1:3, :);

% empty reprojection matrix
rep_image_pixels = zeros(3, size(im_pixels, 2));
pcl4 = zeros(3, size_pcl);

% dividing by the third coordinate --> [u/w v/w 1]
for i = 1 : size(im_pixels, 2)
    rep_image_pixels(:, i) = im_pixels(:, i) ./ im_pixels(3, i);
end
for i = 1 : size_pcl
    pcl4(:, i) = pcl3(:, i) ./ pcl3(3, i);
end

% rounding off to the next pixel integer value
rep_image_pixels = round(rep_image_pixels);
pcl5 = round(pcl4);

% calculating reprojection error
rep_error = rep_image_pixels(1:2,:) - image_pixels(1:2,:);

% replacing third row with disparity values
pcl5(3,:) = disp;

% combining the point cloud with the ground truth points
% pcl6 = [pcl5, rep_image_pixels];

end