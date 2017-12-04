function [marray, narray] = seams_to_mnarrays(hseams, vseams, rows, cols)
    % Function transforms horizontal and verticals seams arrays in two 
    % arrays of rows and columns. Pass to the function hseams and vseams 
    % arrays, cols (number of columns in image) and rows(number of rows in image)

    num_horiz_seams = length(hseams);
    num_vert_seams = length(vseams);

    %pixels for horizontal seems that should be deleted
    harray_rows = zeros(1,  cols*num_horiz_seams);
    harray_cols = zeros(1,  cols*num_horiz_seams);
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
    varray_rows = zeros(1,  rows*num_vert_seams);
    varray_cols = zeros(1,  rows*num_vert_seams);
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
end