% crops the projected point cloud pixels to the image from the camera

function [pcl_disp] = crop_image(size_pcl, pcl_pixels)

pcl_crop = [];
j = 1;

for i = 1 : size_pcl
    if pcl_pixels(1, i) <= 2208 && pcl_pixels(2, i) <= 1242 && pcl_pixels(1, i) > 0 && pcl_pixels(2, i) > 0
        pcl_crop(:, j) = pcl_pixels(:, i);
        j = j + 1;
    end
end
pcl_disp = pcl_crop;

end