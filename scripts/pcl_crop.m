% crops the projected point cloud pixels to the image from the camera

crop_size = size_pcl;
pcl_cr = [];
j = 1;
for i = 1 : crop_size
    if pcl6(1, i) <= 2208 && pcl6(2, i) <= 1242 && pcl6(2, i) > 0
        pcl_cr(:, j) = pcl6(:, i);
        j = j + 1;
    end
end

figure
imshow('left-rect-frame20-gray.png');
hold on
scatter(pcl_cr(1, :), pcl_cr(2, :));
axis equal
