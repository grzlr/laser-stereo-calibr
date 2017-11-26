% create the disparity map from the projected and cropped point cloud 
function [disparity_image, disp_range] = disparity_gen(pcl_disp, image_resolution)

% creating a blank image matrix --> image_resolution(1) - length (columns)
% image_resolution(2) - height (rows) of output image
% disparity_image = nan(image_resolution(2), image_resolution(1));
disparity_image = zeros(image_resolution(2), image_resolution(1));


for i = 1 : size(pcl_disp, 2)
    x = pcl_disp(1, i);
    y = pcl_disp(2, i);
    
    if disparity_image(y, x) ~= nan || disparity_image(y, x) ~= 0
        if disparity_image(y, x) < pcl_disp(3, i)
            disparity_image(y, x) = pcl_disp(3, i);
        end
    
    else
        disparity_image(y, x) = pcl_disp(3, i);
        
    end
    
end

[max_disp, i_max] = max(disparity_image(:));
[min_disp, i_min] = min(disparity_image(:));
disp_range = [min_disp max_disp];

end