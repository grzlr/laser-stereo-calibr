% this is the main function that loads the data and calls the associated
% functions
% set flag = 1/2/3
% path = 1 for the fixed hardcoded path or 0 for selecting folders manually

function [] = main(flag, path)

if path == 0
    data_path = uigetdir('', 'select data parameters folder path');
    script_path = uigetdir('', 'select scripts folder path');
    pcl_path = uigetdir('', 'select point cloud data folder path');
    image_path = uigetdir('', 'select the image folder for comparison');

else
    data_path = '/home/rohit/code/calibration_workspace/data/test/';
    script_path = '/home/rohit/code/calibration_workspace/scripts/';
    pcl_path = uigetdir('', 'select point cloud data folder path');
    image_path = uigetdir('', 'select the image folder for comparison');

end
    
% reading the files
[R, t, K, world_points_raw, image_points, origin, baseline] = read_files(data_path);

% calculating the projections and reprojection error for the correspondence
% points
[pcl_pixels, rep_error, size_pcl, rep_image_pixels] = pcl_projection(pcl_path, R, t, K, world_points_raw, image_points, origin, baseline);

% cropping point cloud disparity output to the camera FOV
[pcl_disp] = crop_image(size_pcl, pcl_pixels); 

% generate a disparity image
[disparity_image] = disparity_gen(pcl_disp);

% plot 
plot_tool(data_path, pcl_path, image_path, pcl_disp, image_points, rep_image_pixels, disparity_image, flag);

cd(script_path);
print(rep_error);

end
