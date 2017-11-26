% disparity plotter for plotting the disparity generated from stereo
% algorithms

% output disparity image resolutions --> 2.2K 1080p 720p WVGA
% Reference: https://www.stereolabs.com/zed/specs/
output_resolution = [2208 1242; 1920 1080; 1280 720; 672 376];

% resolution flag 1/2/3/4 --> 2.2K/1080p/720p/WVGA
res_flag = 1;

% read disparity matrix from text
fid = fopen('../data/disp-files/disparity_int.txt');

disp = fscanf(fid, '%f', output_resolution(res_flag, :));
disp = disp';

fclose(fid);

figure
h2 = imshow(disp, 'DisplayRange', [0 255]);
% set(h2, 'AlphaData', 0.5);

% calculating the disparity range
[max_disp, i_max] = max(disp(:));
[min_disp, i_min] = min(disp(:));
disp_range = [min_disp max_disp];