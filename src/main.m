%clearing command line
clc;
%closing all plot windows etc.
close all;

%openning modules
import tools.read_images;
import seam.*;

path_to_folder = '../data/';

file_names = read_images(path_to_folder);

img = imread(strcat(path_to_folder, file_names{1}));
%imshow(img);

test = [[1, 2, 3]; [1, 2, 4]; [1, 6, 3]];
%print(shortestpath(test));
p = create_hseam(test, test, 2);

% for i = 1:length(p.Nodes)
%     coords = p.Nodes{i}.get_coords();
%     img(coords(1), coords(2)) = 0;
% end
% 
% imshow(img);
