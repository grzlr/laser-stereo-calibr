% plots disparity contrasted with the original image 

function [] = plot_disp(image_path, disparity_image)
    
figure
imshow(image_path);
% set(h1, 'AlphaData', 1);
hold on
h2 = imshow(disparity_image, 'DisplayRange', [0 100]);
set(h2, 'AlphaData', 0.5);
    
end
