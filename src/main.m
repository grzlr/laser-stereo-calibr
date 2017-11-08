% The main script that loads the data and calls the associated
% functions

%% Setting flags and obtaining directory paths

% set flag = 0/1/2/3/4 for different plots
plot_flag = 4;

% set path = 1 for the fixed hardcoded path or 0 for selecting folders manually
path_flag = 1;

% set write = 1 if you want to save the disparity image and range 
write_flag = 0;

% output disparity image resolutions --> 2.2K 1080p 720p WVGA
% Reference: https://www.stereolabs.com/zed/specs/
output_resolution = [2208 1242; 1920 1080; 1280 720; 672 376];

% resolution flag 1/2/3/4 --> 2.2K/1080p/720p/WVGA
res_flag = 3;

%% obtaining paths
[data_path, source_path, pcl_path, image_path] = get_path(path_flag);

%% reading files
% reading the files
[R, t, K, world_points_raw, image_points, origin, baseline] = read_files(data_path);

%% projections and disparity computation
% calculating the projections and reprojection error for the correspondence
% points
[pcl_pixels, rep_error, size_pcl, rep_image_pixels] = pcl_projection(pcl_path, R, t, K, world_points_raw, image_points, origin, baseline);

% cropping point cloud disparity output to the camera FOV
[pcl_disp] = crop_image(size_pcl, pcl_pixels, output_resolution(res_flag, :)); 

% generate a disparity image
[disparity_image, disp_range] = disparity_gen(pcl_disp, output_resolution(res_flag, :));

%% plotting tools
% superimposing the projected point cloud points over the camera image
if plot_flag == 1
   plot_pcl(image_path, pcl_disp);
   
% showing the error between projected gt points and selected image points    
elseif plot_flag == 2
   plot_error(image_path, image_points, rep_image_pixels);
              
% plotting disparity superimposed on the the camera image              
elseif plot_flag == 3
   plot_disp(image_path, disparity_image);

% plotting only disparity
elseif plot_flag == 4
    plot_tool(disparity_image);

elseif plot_flag == 0
    disp('no plotting selected');
    
end

%% writing to files
if (write_flag == 1)
    cd(data_path);
    
    % writing disparity range
    dlmwrite('disparity_range.txt', disp_range);

    % writing disparity image
    dlmwrite('disparity_image.txt', disparity_image);

end
%% wrapping up
cd(source_path);

fprintf('the projection error for gt points is \n');
disp(rep_error);