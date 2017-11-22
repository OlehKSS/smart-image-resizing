%clearing command line
clc;
%closing all plot windows etc.
close all;

import delete.delete_seams;

image = [1,2,3;4,5,6]
xarray = [2,1];
yarray = [2,1];

%Number of total pixels to delete
num_pixels = length(xarray);

%Size of the original image
[height, width] = size(image);

%Add one to each value in the image for the deletion condition, in case 
%zeros already exist.
image = image + 1.;

%Find the indices of the points to delete and assign 0 to them.
for i = 1: num_pixels
    index = sub2ind(size(image), yarray(i), xarray(i));
    image(index) = 0;
end

image 

%Flatten the original image into a 1D column vector
image = image(:);

%Delete all the elements equating to zero
image = image(image ~= 0);

%Subtract one to obtain the original pixel values
image = image - 1.;

%Reshape the image to new dimensions
height = height - 0;
width = width - 1;
new_image = reshape(image,height,width)
%new_image = delete_seams(image,xarray,yarray,0,1)
