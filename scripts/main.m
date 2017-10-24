% this is the main function that loads the data and calls the associated
% functions

function [] = main(flag)

% data_path = uigetdir('/home/rohit/', 'select data parameters folder path');
% script_path = uigetdir('/home/rohit/', 'select scripts folder path');
% pcl_path = uigetdir('/home/rohit/', 'select point cloud data folder path');
% image_path = uigetdir('/home/rohit/', 'select the stereo image folder path');


data_path = '/home/rohit/code/calibration_workspace/data/test/';
script_path = '/home/rohit/code/calibration_workspace/scripts/';
pcl_path = '/home/rohit/code/calibration_workspace/data/day-0/';
image_path = '/home/rohit/code/calibration_workspace/data/day-0/';

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

end
