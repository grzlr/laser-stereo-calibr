% create the disparity map from the projected and cropped point cloud 
function [disparity_image, disp_range] = disparity_gen(pcl_disp)

% creating a blank image matrix
disparity_image = nan(1242, 2208);

for i = 1 : size(pcl_disp, 2)
    x = pcl_disp(1, i);
    y = pcl_disp(2, i);            
    disparity_image(y, x) = pcl_disp(3, i);
end

[max_disp, i_max] = max(disparity_image(:));
[min_disp, i_min] = min(disparity_image(:));
disp_range = [min_disp max_disp];

end