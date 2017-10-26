% general purpose plotting
function [] = plot_tool(data_mat)

figure
h2 = imshow(data_mat, 'DisplayRange', [0 200]);
% set(h2, 'AlphaData', 0.5);

end