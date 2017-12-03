
%Function that deletes vertical "seams" in image. Pass to the function the
%original image, marray and narray, which are the coordinates of the pixels
%to be deleted, and the number of vertical seams, respectively. Marray and
%narray vs should be in the format 1 x N, where N is the number of pixels
%to be deleted. The output is the image with the seams removed.

function new_image = delete_vertical_seams(image, narray, marray, num_vert_seams)

    %Number of total pixels to delete
    num_pixels = length(narray);

    %Size of the original image
    [height, width, ~] = size(image);
    if size(image,3)==3
        depth = 3;
    else
        depth = 1;
    end
    
    %Add one to each value in the image for the deletion condition, in case 
    %zeros already exist.
    addoneimage = image + 1.;
    
    %Find the indices of the points to delete and assign 0 to them.
    for z = 1: depth
        for i = 1: num_pixels
            addoneimage(marray(i),narray(i),z) = 0;
        end
    end

    %Flatten the original image into a 1D row vector
    k = 1;
    flattened_image = zeros(1,height*width*depth);
    for z = 1 : depth
        for i = 1 : height
            for j = 1 : width
            flattened_image(k) = addoneimage(i,j,z);
            k = k + 1;
            end
        end
    end

    %Delete all the elements equating to zero
    flattened_image = flattened_image(flattened_image ~= 0);

    %Subtract one to obtain the original pixel values
    flattened_image = flattened_image - 1.;

    %Reshape the image to the new dimensions
    width = width - num_vert_seams;
    new_image = zeros(height,width,depth);
    k = 1;
    for z = 1 : depth
        for i = 1 : height
            for j = 1 : width
                new_image(i,j,z) = flattened_image(k);
                k = k + 1;
            end
        end
    end
    
    %Convert new_image to uint8 if it was originally
    if isfloat(image) == 0
        new_image = uint8(new_image);
    end
end