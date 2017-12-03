%clearing command line and variables
clc;
clear variables;
%closing all plot windows etc.
close all;

%openning modules
import tools.read_images;
import energy_funcs.e1_error;
import energy_funcs.hog_feature_vector;
import seam.*;

path_to_folder = '../data/';

file_names = read_images(path_to_folder);

img = imread(strcat(path_to_folder, file_names{3}));
energy_e1 = e1_error(img);
% This how we want to use energy function
%but something clearly incorrect in the function itself
energy_h = hog_feature_vector(img);
%subplot(2, 1, 1);
%imshow(energy_h);
subplot(2, 1, 1);
imshow(energy_e1);

%it's just a test, you can remove it
p = create_vseam(img, energy_e1, 360);
p2 = create_vseam(img, energy_e1, 400);
p3 = create_vseam(img, energy_e1, 600);
p4 = create_hseam(img, energy_e1, 200);
for i = 1:length(p.Nodes)
    coords = p.Nodes{i}.get_coords();
    coords2 = p2.Nodes{i}.get_coords();
    coords3 = p3.Nodes{i}.get_coords();
    coords4 = p4.Nodes{i}.get_coords();
    img(coords(1), coords(2)) = 0;
    img(coords2(1), coords2(2)) = 0;
    img(coords3(1), coords3(2)) = 0;
    img(coords4(1), coords4(2)) = 0;
end
for i = 1:length(p4.Nodes)
    coords4 = p4.Nodes{i}.get_coords();
    img(coords4(1), coords4(2)) = 0;
end
subplot(2, 1, 2);
imshow(img);
