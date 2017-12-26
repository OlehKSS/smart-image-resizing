%clearing command line
clc;
%closing all plot windows etc.
close all;
clear all;

%openning modules
import tools.read_images;
import energy_funcs.*;
import seam.*;
import img.shrink;
import img.grow;

path_to_folder = '../data/';

file_names = read_images(path_to_folder);

%img = imread(strcat(path_to_folder, file_names{3}));
img = imread('small_images/image12.jpg');


%img_small = shrink(img, @e1_error, 100, 100);
%imshow(img_small);

img_big = grow(img, @e1_error, 150, 200);
imshow(img_big);

