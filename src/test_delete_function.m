%clearing command line
clc;
%closing all plot windows etc.
close all;

import add.add_vertical_seams;
import add.add_horizontal_seams;

image = randn(5,5)
xarray = [4,5,5,5,5];
yarray = [1,2,3,4,5];

new_image = add_vertical_seams(image, xarray, yarray, 1)
%image = im2double(imread('s.jpg'));