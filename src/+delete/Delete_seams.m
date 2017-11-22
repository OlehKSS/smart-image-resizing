
%Function that deletes "seams" in image. Pass to the function the original 
%image, the x values of all seams to be deleted, the y values of all seams
%to be deleted, the number of horizontal seams, and the number of vertical
%seams, respectively. Xarray and yarray vs should be in the format 
% 1 x N, where N is the number of pixels. The output is the image with
%the seams removed.

function new_image = delete_seams(image, xarray, yarray, num_x_seams, num_y_seams)

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

%Flatten the original image into a 1D column vector
image = image(:);

%Delete all the elements equating to zero
image = image(image ~= 0);

%Subtract one to obtain the original pixel values
image = image - 1.;

%Reshape the image to new dimensions
height = height - num_x_seams
width = width - num_y_seams
new_image = reshape(image,[height,width]);
end
