% this is the main function that loads the data and calls the associated
% functions
% set flag = 1/2/3 for different plots
plot_flag = 3;
% set path = 1 for the fixed hardcoded path or 0 for selecting folders manually
path_flag = 2;

if path_flag == 0
    data_path = uigetdir('', 'select data parameters folder');
    source_path = uigetdir('', 'select source code folder');
    pcl_file = uigetfile({'*.pcd'; '*.ply'}, 'select point cloud data file');    
    pcl_dir = uigetdir('', 'select point cloud data folder');
    image_file = uigetfile({'*.png'; '*.jpg'}, 'select the image file');
    image_dir = uigetdir('', 'select the image folder');

elseif path_flag == 1
    data_path = '/home/rohit/code/calibration_workspace/data/test/';
    source_path = '/home/rohit/code/calibration_workspace/src/';
    pcl_file = uigetfile({'*.pcd'; '*.ply'}, 'select point cloud data file');    
    pcl_dir = uigetdir('', 'select point cloud data folder');
    image_file = uigetfile({'*.png'; '*.jpg'}, 'select the image file');
    image_dir = uigetdir('', 'select the image folder');

else
    data_path = '/media/rohit/Data/dataset_dumps/stereo_dataset/zed/scene1/1/points/';
    source_path = '/home/rohit/code/calibration_workspace/src/';
    pcl_file = 'scene1_dense_p1.ply';    
    pcl_dir = '/home/rohit/Desktop/dataset-drafts/scene1/';
    image_file = '1_f08_rect_left.png';
    image_dir = '/media/rohit/Data/dataset_dumps/stereo_dataset/zed/scene1/1/rect/selected/';
    
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

% superimposing the projected point cloud points over the camera image
if plot_flag == 1
    plot_pcl(image_path, pcl_disp);
   
% showing the error between projected gt points and selected image points    
elseif plot_flag == 2
   plot_error(image_path, image_points, rep_image_pixels);
              
% plotting disparity superimposed on the the camera image              
elseif plot_flag == 3
   plot_disp(image_path, disparity_image);

end

cd(source_path);

fprintf('the projection error for gt points is \n');
disp(rep_error);