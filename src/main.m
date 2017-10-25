% this is the main function that loads the data and calls the associated
% functions
% set flag = 1/2/3 for different plots
% set path = 1 for the fixed hardcoded path or 0 for selecting folders manually

function [] = main(flag, path)

if path == 0
    data_path = uigetdir('', 'select data parameters folder');
    source_path = uigetdir('', 'select source code folder');
    pcl_file = uigetfile({'*.pcd'; '*.ply'}, 'select point cloud data file');    
    pcl_dir = uigetdir('', 'select point cloud data folder');
    image_file = uigetfile({'*.png'; '*.jpg'}, 'select the image file');
    image_dir = uigetdir('', 'select the image folder');

else
    data_path = '/home/rohit/code/calibration_workspace/data/test/';
    source_path = '/home/rohit/code/calibration_workspace/src/';
    pcl_file = uigetfile({'*.pcd'; '*.ply'}, 'select point cloud data file');    
    pcl_dir = uigetdir('', 'select point cloud data folder');
    image_file = uigetfile({'*.png'; '*.jpg'}, 'select the image file');
    image_dir = uigetdir('', 'select the image folder');

end

% combining directory and file paths for the pcl and image files
image_path = fullfile(image_dir, image_file);
pcl_path = fullfile(pcl_dir, pcl_file);
    
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

cd(source_path);
fprintf('the projection error for gt points is \n');
disp(rep_error);

end
