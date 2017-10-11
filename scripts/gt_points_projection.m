clear;
load ('../data/points.mat');

% rotation and translation matrices received from the solver
R = [-0.85682262, -0.51557884, -0.00578405; -0.06444674, 0.11821822, -0.99089408; 0.5115678, -0.8486477, -0.13451942];
t = [-0.19138781; 0.0181162; -0.07892774];
% camera instrinsics
fx = 1399.53;
fy = fx;
cx = 1169.16;
cy = 703.221;
K = [fx 0 cx; 0 fy cy; 0 0 1];

% constructing the transformation matrix
T = [R, t; 0 0 0 1];

% inverting the transformation matrix for other operations
T_inv = [R', -R' * t; 0 0 0 1];

% transposing and homogenising the world_points matrix
world_points = [world_points'; ones(1, size(world_points, 1))];

% subtracting the origin from the world_points
world_points(1:3, :) = world_points(1:3, :) - origin';

% transposing and homogenising the image_points matrix
image_pixels = [image_points'; ones(1, size(image_points, 1))];

% calculating the points w.r.t camera origin
camera_points = T * world_points;

% projecting camera_points to 2D image points using K
im_pixels = K * camera_points(1:3, :);

% empty reprojection matrix
rep_image_pixels = zeros(3, size(im_pixels, 2));

% dividing by the third coordinate --> [u/w v/w 1]
for i = 1 : size(im_pixels, 2)
    rep_image_pixels(:,i) = im_pixels(:,i) ./ im_pixels(3, i);
end

% rounding off to the next pixel integer value
rep_image_pixels = round(rep_image_pixels);

% calculating reprojection error
error = rep_image_pixels(1:2,:) - image_pixels(1:2,:);