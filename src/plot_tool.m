% plotter

function [] = plot_tool(data_path, pcl_path, image_path, pcl_disp, image_points, rep_image_pixels, disparity_image, flag)

image_pixels = image_points';
pcl_pixels = rep_image_pixels(1:2, :);

% superimposing the projected point cloud points over the camera image
if flag == 1
    figure
    imshow(image_path);
    hold on
    scatter(pcl_disp(1, :), pcl_disp(2, :));
    axis equal
   
% showing the error between projected gt points and selected image points    
elseif flag == 2
    figure
    imshow(image_path);
    hold on
    scatter(image_pixels(1, :), image_pixels(2, :), 'MarkerEdgeColor',[1 0 0],...
                  'MarkerFaceColor',[0.9 0.1 0.1],...
                  'LineWidth',1.0);
    scatter(pcl_pixels(1, :), pcl_pixels(2, :), 'MarkerEdgeColor',[0 0 1], ...
        'MarkerFaceColor',[0.1 0.1 0.9],...
                  'LineWidth',1.0);
              
% plotting disparity superimposed on the the camera image              
elseif flag == 3
    figure
    imshow(image_path);
    % set(h1, 'AlphaData', 1);
    hold on
    h2 = imshow(disparity_image, 'DisplayRange', [45 71]);
    set(h2, 'AlphaData', 0.5); 

end



end