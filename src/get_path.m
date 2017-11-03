%% path load function 

function [data_path, source_path, pcl_path, image_path] = get_path(path_flag)

if path_flag == 0
    data_path = uigetdir('', 'select data parameters folder');
    source_path = uigetdir('', 'select source code folder');
    [pcl_file, pcl_dir] = uigetfile({'*.pcd'; '*.ply'}, 'select point cloud data file');
    [image_file, image_dir] = uigetfile({'*.png'; '*.jpg'}, 'select the image file');
   
% hardcoded option
else 
    data_path = '/media/rohit/Data/dataset_dumps/stereo_dataset/zed/scene1/4/points/';
    source_path = '/home/rohit/code/calibration_workspace/src/';
    pcl_file = 'scene1_dense_p1.ply';    
    pcl_dir = '/home/rohit/Desktop/dataset-drafts/scene1/';

    % small hack for fast prototyping
    image_dir = 'image path';
    image_file = 'not provided';
    %[image_file, image_dir] = uigetfile({'*.png'; '*.jpg'}, 'select the image file');

 
end

% combining directory and file paths for the pcl and image files
image_path = fullfile(image_dir, image_file);
pcl_path = fullfile(pcl_dir, pcl_file);

end