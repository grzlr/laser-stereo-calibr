% showing the error between projected gt points and selected image points    

function [] = plot_error(image_path, image_points, rep_image_pixels)

image_pixels = image_points';
pcl_pixels = rep_image_pixels(1:2, :);

figure
imshow(image_path);
hold on
scatter(image_pixels(1, :), image_pixels(2, :), 'MarkerEdgeColor',[1 0 0],...
        'MarkerFaceColor',[0.9 0.1 0.1],...
        'LineWidth',1.0);
scatter(pcl_pixels(1, :), pcl_pixels(2, :), 'MarkerEdgeColor',[0 0 1], ...
        'MarkerFaceColor',[0.1 0.1 0.9],...
        'LineWidth',1.0);
axis equal

end
