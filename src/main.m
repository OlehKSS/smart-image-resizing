%clearing command line
clc;
%closing all plot windows etc.
close all;

%openning modules
import tools.read_images;
import energy_funcs.*;
import seam.*;
import img.shrink;

path_to_folder = '../data/';

file_names = read_images(path_to_folder);

%img = imread(strcat(path_to_folder, file_names{3}));
img = imread('s.jpg');
[rows, cols, levels] = size(img);
energy_e1 = e1_error(img);
% This how we want to use energy function
%but something clearly incorrect in the function itself
energy_h = hog(img);

img_small = shrink(img, energy_e1, 59, 129);
imshow(img_small);

%creation of seams map
%seams_map = zeros(rows, cols);
%it's just a test, you can remove it
% p = create_vseam(img, energy_e1, seams_map, 360);
% p2 = create_vseam(img, energy_e1, seams_map, 400);
% p3 = create_vseam(img, energy_e1, seams_map, 600);
% p4 = create_hseam(img, energy_e1, seams_map, 200);
% for i = 1:length(p.Nodes)
%     coords = p.Nodes{i}.get_coords();
%     coords2 = p2.Nodes{i}.get_coords();
%     coords3 = p3.Nodes{i}.get_coords();
%     coords4 = p4.Nodes{i}.get_coords();
%     img(coords(1), coords(2)) = 0;
%     img(coords2(1), coords2(2)) = 0;
%     img(coords3(1), coords3(2)) = 0;
%     img(coords4(1), coords4(2)) = 0;
% end
% for i = 1:length(p4.Nodes)
%     coords4 = p4.Nodes{i}.get_coords();
%     img(coords4(1), coords4(2)) = 0;
% end
% subplot(2, 1, 1);
% imshow(energy_h);
% subplot(2, 1, 2);
% imshow(img);
