%clearing command line
clc;
%closing all plot windows etc.
close all;

import delete.delete_seams;

image = randn(2,3)
xarray = [3,1];
yarray = [2,1];

new_image = delete_seams(image, xarray, yarray, 0, 1)
