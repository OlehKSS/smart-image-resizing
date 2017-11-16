function new_image = delete_seams(image, xarray, yarray, num_x_seams, num_y_seams)

%Number of total pixels to delete
length = length(xarray);

%Size of the original image
[height, width] = size(image);

%Add one to each value in the array for the deletion condition in case 
%zeros already exist.
image = image + 1.;

%Find the indices of the points to delete
for i = 1: length
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
height = height - num_y_seams
width = width - num_x_seams
new_image = reshape(image,[height,width]);
end
