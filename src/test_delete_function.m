%clearing command line
clc;
%closing all plot windows etc.
close all;

import delete.delete_vertical_seams;
import delete.delete_horizontal_seams;
import add.add_vertical_seams;
import add.add_horizontal_seams;

image = randn(2,3,3)
xarray = [3,2,1];
yarray = [1,2,1];

new_image = add_horizontal_seams(image, xarray, yarray, 1)
