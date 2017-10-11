%% plotting tools

image_size1 = [2208, 1242]; 
image_size2 = [round(2 * cx), round(2 * cy)];

% changing origin of ground truth pixels taken from original image
gt_pixels(1, :) = image_pixels(1, :);
gt_pixels(2, :) = image_pixels(2, :);
% gt_pixels(2, :) = image_size1(2) - image_pixels(2, :);

% changing origin of pixels for orienting with image show origin 
im_pixels(1, :) = rep_image_pixels(1, :);
im_pixels(2, :) = rep_image_pixels(2, :);
% im_pixels(2, :) = image_size2(2) - rep_image_pixels(2, :);

figure
imshow('left-rect-frame20-gray.png');
hold on
scatter(gt_pixels(1, :), gt_pixels(2, :), 'MarkerEdgeColor',[1 0 0],...
              'MarkerFaceColor',[0.9 0.1 0.1],...
              'LineWidth',1.0);
scatter(im_pixels(1, :), im_pixels(2, :), 'MarkerEdgeColor',[0 0 1], ...
    'MarkerFaceColor',[0.1 0.1 0.9],...
              'LineWidth',1.0);
