
%Function that adds vertical "seams" to an image. Pass to the function the
%original image, marray and narray, which are the coordinates of the pixels
%to be added, and the number of vertical seams, respectively. Marray and
%narray vs should be in the format 1 x N, where N is the number of pixels
%to be deleted. The output is the image with the seams added.

function new_image = add_vertical_seams(original_image, marray, narray, num_vert_seams)
    
    %Convert image to double to operate on
    image = double(original_image);

    %Number of total pixels to add 
    num_pixels = length(narray);

    %Transpose the image to perform operations
    image = permute(image, [2,1,3]);
    
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
        indicies(i) = sub2ind([height,width],marray(i),narray(i));
    end
    
    indicies = sort(indicies);
    
    %Flatten the image into a 1D column vector (or 3D if image is in color)
    flattened_image = reshape(image,[height*width,1,depth]);
    
    %At the locations of the index, insert an element, average the values above
    %and below it, and add one to the changing list of indices.
    height = height + num_vert_seams
    expanded_flattened_image = zeros(height*width,1,depth);
    for z = 1 : depth
        %Make a copy of the list of indicies, as one will need to change in
        %values, as the seams are added
        indicies_changing = indicies;
        
        expanded_flattened_image(1:indicies_changing(1),1,z) = flattened_image(1:indicies(1),1,z);
        expanded_flattened_image(indicies_changing(1)+1,1,z) = (flattened_image(indicies(1),1,z) + flattened_image(indicies(1)+1,1,z))/2;
        indicies_changing = indicies_changing + 1;
        for i = 2 : num_pixels
            expanded_flattened_image(indicies_changing(i-1)+1:indicies_changing(i),1,z) = flattened_image(indicies(i-1)+1:indicies(i),1,z);
            %Condition in case the seam passes through the last column of
            %the image
            if rem(indicies(i),(height-num_vert_seams)) == 0
                expanded_flattened_image(indicies_changing(i)+1,1,z) = flattened_image(indicies(i),1,z);
            else
                expanded_flattened_image(indicies_changing(i)+1,1,z) = (flattened_image(indicies(i),1,z) + flattened_image(indicies(i)+1,1,z))/2;
            end
            indicies_changing = indicies_changing + 1;
        end
        %Get the values for the rest of the image(after the last pixel has been
        %inserted
        expanded_flattened_image(indicies_changing(i)+1:length(expanded_flattened_image),1,z) = flattened_image(indicies(i)+1:length(flattened_image),1,z);
    end
    
    %Reshape the image to the new dimensions
    new_image = reshape(expanded_flattened_image,[height,width,depth]);
    
    %Transpose the image back to original
    new_image = permute(new_image, [2,1,3]);
    
    %Convert new_image to uint8 if it was initially
    if isfloat(original_image) == 0
        new_image = uint8(new_image);
    end

end