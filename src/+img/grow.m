function img = grow(img, energy_func, rows_new, cols_new)
    % GROW englarges an image using provided energy function and new shape,
    % returns the new image as a result of the function execution
    % out = grow(img, energy_func, rows_new, cols_new) img - input image,
    % energy_func - energy function to use, rows_new - number of 
    % of output image rows,  cols_new - number columns of output image
    
    import seam.create_hseams;
    import seam.create_vseams;
    import seam.seams_to_mnarrays;
    import add.add_horizontal_seams;
    import add.add_vertical_seams;
    
    [rows_old, cols_old, ~] = size(img);
    
    hnumber_of_pxs = rows_new - rows_old;
    vnumber_of_pxs = cols_new - cols_old;
    
    if ((hnumber_of_pxs < 0) || (vnumber_of_pxs < 0))
        error('Incorrect new image size');
    end
    
    %start from horizontal, then vertical
    if (hnumber_of_pxs > 0)
        energy_map = energy_func(img);
        hseams = create_hseams(img, energy_map, hnumber_of_pxs);
        [marray_h, narray_h] = seams_to_mnarrays(hseams, [], rows_old, cols_old);
        img = add_horizontal_seams(img, narray_h, marray_h, length(hseams));
    end
    
    if (vnumber_of_pxs > 0)
        energy_map = energy_func(img);
        %Updating image size in case we changed it in previous statement
        [rows_old, cols_old, ~] = size(img);
        vseams = create_vseams(img, energy_map, vnumber_of_pxs);
        [marray_v, narray_v] = seams_to_mnarrays([], vseams, rows_old, cols_old);
        img = add_vertical_seams(img, narray_v, marray_v, length(vseams));
    end
end
