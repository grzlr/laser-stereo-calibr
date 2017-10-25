% superimposing the projected point cloud points over the camera image

function [] = plot_pcl(image_path, pcl)

figure
imshow(image_path);
hold on
scatter(pcl(1, :), pcl(2, :));
axis equal
   
end