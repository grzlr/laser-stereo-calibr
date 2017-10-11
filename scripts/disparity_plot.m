% this script is used to create the disparity map from the projected point
% cloud points

pcl_projection;
disp_calc;
pcl_crop;

pcl_disp = pcl_cr;

% creating a blank image matrix
disp_img = nan(1242, 2208);

for i = 1 : size(pcl_disp, 2)
    x = pcl_disp(1, i);
    y = pcl_disp(2, i);            
%     disp_img(y, x) = 255;
    disp_img(y, x) = pcl_disp(3, i);
end
    
figure
h1 = imshow('left-rect-frame20-gray.png');
% set(h1, 'AlphaData', 1);
hold on
h2 = imshow(disp_img, 'DisplayRange', [45 71]);
set(h2, 'AlphaData', 0.5); 