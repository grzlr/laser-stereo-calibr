% saving cursor points and reordering them
a = cell2mat(Position);
image_points = nan(size(a));
 
rows = size(a, 1);
 
for i = 1 : size(a, 1)
    image_points(i, :) = a(rows - i + 1, :);
end

folder_path = uigetdir('', 'specify folder to save file in');
f = fullfile(folder_path, 'image_points.txt');

% writing the points to a file
dlmwrite(f, image_points, 'delimiter', ' ', 'newline', 'unix');