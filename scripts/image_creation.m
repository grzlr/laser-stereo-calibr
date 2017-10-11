% this script reads in the values from the projected points in the image
% space and creates a matrix for display as an image

arr = cam3(1:2,:);

M = max (arr, [], 2);

% creating a blank image matrix
img = zeros(M(1), M(2));

for i = 1 : size(arr,2)
    for j = 1 : 2
        if j == 1
            x = arr(j, i);
            
        else
            y = arr(j, i);
            
        end
    end
    img(x,y) = 255;
end