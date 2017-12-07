
%Function that adds vertical "seams" to an image. Pass to the function the
%original image, marray and narray, which are the coordinates of the pixels
%to be added, and the number of vertical seams, respectively. Marray and
%narray vs should be in the format 1 x N, where N is the number of pixels
%to be deleted. The output is the image with the seams added.

function new_image = add_vertical_seams(image, narray, marray, num_vert_seams)

    %Number of total pixels to add 
    num_pixels = length(narray);

    %Size of the original image
    [height, width, ~] = size(image);
    if size(image,3)==3
        depth = 3;
    else
        depth = 1;
    end
    
    %Find the indices for the seams
    indicies = zeros(1,num_pixels);
    for i = 1 : num_pixels
        indicies(i) = width*(marray(i)-1) + narray(i);
    end
    
    indicies = sort(indicies);
    
    %Flatten the image into a 1D row vector (or 3D if image is in color)
    flattened_image = zeros(1,height*width,depth);
    for z = 1 : depth
        k = 1;
        for i = 1 : height
            for j = 1 : width
                flattened_image(1,k,z) = image(i,j,z);
                k = k + 1;
            end
        end
    end
    
    %At the locations of the index, insert an element, average the values above
    %and below it, and add one to the changing list of indices.
    width = width + num_vert_seams;
    expanded_flattened_image = zeros(1,height*width,depth);
    for z = 1 : depth
        %Make a copy of the list of indicies, as one will need to change in
        %values, as the seams are added
        indicies_changing = indicies;
        
        expanded_flattened_image(1,1:indicies_changing(1),z) = flattened_image(1,1:indicies(1),z);
        expanded_flattened_image(1,indicies_changing(1)+1,z) = (flattened_image(1,indicies(1),z) + flattened_image(1,indicies(1)+1,z))/2;
        indicies_changing = indicies_changing + 1;
        for i = 2 : num_pixels
            expanded_flattened_image(1,indicies_changing(i-1)+1:indicies_changing(i),z) = flattened_image(1,indicies(i-1)+1:indicies(i),z);
            %Condition in case the seam goes through the last pixel on the
            %bottom of an image
            if indicies(i) == height*width
            	expanded_flattened_image(1,indicies_changing(i)+1,z) = flattened_image(1,indicies(i),z);
            else    
                expanded_flattened_image(1,indicies_changing(i)+1,z) = (flattened_image(1,indicies(i),z) + flattened_image(1,indicies(i)+1,z))/2;
                indicies_changing = indicies_changing + 1;
            end
        end
        %Get the values for the rest of the image(after the last pixel has been
        %inserted)
        expanded_flattened_image(1,indicies_changing(i)+1:length(expanded_flattened_image),z) = flattened_image(1,indicies(i)+1:length(flattened_image),z);
    end
    
    %Reshape the image to the new dimensions
    expanded_flattened_image = transpose(expanded_flattened_image(:));
    new_image = zeros(height,width,depth);
    k = 1;
    for z = 1 : depth
        for i = 1 : height
            for j = 1 : width
                new_image(i,j,z) = expanded_flattened_image(k);
                k = k + 1;
            end
        end
    end
    
    %Convert new_image to uint8 if it was originally
    if isfloat(image) == 0
        new_image = uint8(new_image);
    end

end