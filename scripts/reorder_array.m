 
% saving cursor points and reordering them
a = cell2mat(Position);
image_points = nan(size(a));
 
rows = size(a, 1);
 
for i = 1 : size(a, 1)
    image_points(i, :) = a(rows - i + 1, :);
end

% writing the points to a file
dlmwrite('image_points.txt', image_points, 'delimiter', ' ', 'newline', 'unix');