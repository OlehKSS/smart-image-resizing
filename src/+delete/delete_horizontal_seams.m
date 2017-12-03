
%Function that deletes "seams" in image. Pass to the function the original 
%image, marray and narray, which are the coordinates of the pixels
%to be deleted, the number of horizontal seams, and the number of vertical
%seams, respectively. Marray and narray vs should be in the format 
% 1 x N, where N is the number of pixels to be deleted. The output is the 
%image with the seams removed.

function new_image = delete_seams(image, narray, marray, num_horiz_seams)

%Number of total pixels to delete
num_pixels = length(narray);

%Size of the original image
[height, width, ~] = size(image);

%Add one to each value in the image for the deletion condition, in case 
%zeros already exist.
image = image + 1.;

%Find the indices of the points to delete and assign 0 to them.
for i = 1: num_pixels
    image(marray(i),narray(i)) = 0;
end

%Flatten the original image into a 1D column vector
k = 1;
flattened_image = (1,height*width);
for i = 1 : height
    for j = 1 : width
    flattened_image(k) = image(i,j);
    k = k + 1;
    end
end

%Delete all the elements equating to zero
flattened_image = flattened_image(flattened_image ~= 0);

%Subtract one to obtain the original pixel values
flattened_image = flattened_image - 1.;

%Reshape the image to the new dimensions
height = height - num_horiz_seams;
new_image = zeros(height,width);
k = 1;
for i = 1 : height
    for j = 1 : width
    new_image(i,j) = flattened_image(k);
    k = k + 1;
    end
end
