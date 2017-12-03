function new_image = delete_seams2(image, hseams, vseams)
    % Function that deletes "seams" in image. Pass to the function the original 
    % image, hseams and vseams, which are the horizontal and vertical seams
    % to be deleted.

    import delete.delete_seams;

    num_horiz_seams = length(hseams);
    num_vert_seams = length(vseams);

    %Size of the original image
    [height, width, ~] = size(image);

    % Number of total pixels to delete
    num_pixels = height*num_vert_seams + width*num_horiz_seams;

    %pixels for horizontal seems that should be deleted
    harray_rows = zeros(1,  width*num_horiz_seams);
    harray_cols = zeros(1,  width*num_horiz_seams);
    hindex = 1;
    for i = 1:num_horiz_seams
        temp_rows = hseams(i).get_rows();
        temp_cols = hseams(i).get_columns();

        %length(temp_rows) = width of image
        for j = 1:length(temp_rows)
            harray_rows(hindex) = temp_rows(j);
            harray_cols(hindex) = temp_cols(j);
            hindex = hindex + 1;
        end
    end

    %pixels for vertical seems that should be deleted
    varray_rows = zeros(1,  height*num_vert_seams);
    varray_cols = zeros(1,  height*num_vert_seams);
    vindex = 1;
    for i = 1:num_vert_seams
        temp_rows = vseams(i).get_rows();
        temp_cols = vseams(i).get_columns();

        %length(temp_rows) = width of image
        for j = 1:length(temp_rows)
            varray_rows(vindex) = temp_rows(j);
            varray_cols(vindex) = temp_cols(j);
            vindex = vindex + 1;
        end
    end

    %all pixels that should be deleted combined
    marray = [harray_rows, varray_rows];
    narray = [harray_cols, varray_cols];

    new_image = delete_seams(image, narray, marray, num_horiz_seams, num_vert_seams);
end