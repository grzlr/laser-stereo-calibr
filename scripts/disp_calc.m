% calculation of disparity values for each pixel

disp = zeros(1, size_pcl);
for i = 1 : size_pcl
    disp(i) = (fx * baseline) / pcl2(3, i);    
end

for i = 1 : size(im_pixels, 2)
    disp = [disp, ((fx * baseline) / camera_points(3, i))];
end

disp_round = round(disp);

% projecting camera_points to 2D image points using K
im_pixels = K * camera_points(1:3, :);
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
error = rep_image_pixels(1:2,:) - image_pixels(1:2,:);

% appending gt points
pcl6 = [pcl5, rep_image_pixels];

% replacing third row with disparity values
pcl6(3,:) = disp_round;