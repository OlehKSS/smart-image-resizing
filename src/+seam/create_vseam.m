function out = create_vseam(img, energy_map, start_col)
    [img_rows, img_cols, colors] = size(img);
    
    %creating starting seam node
    sm1 = seam.SeamNode(1, start_col, energy_map(1, start_col));
    nodes = {img_rows};
    nodes{1} = sm1;
    
    %traversing every row starting from second one
    %and creating all possible 8-paths
    for i = 2:img_rows
        parent = nodes{i - 1};
        temp_children = [];
        temp_col_start = parent.Column - 1;
        temp_col_end = parent.Column + 1;

        %checking image boundaries and correcting values
        if (temp_col_start < 1)
            temp_col_start = 1;
        end
        if (temp_col_end > img_cols)
            temp_col_end = img_cols;
        end

        %it might be quicker to
        %take just one with minimum of energy
        for j = temp_col_start : temp_col_end
            temp_children = [temp_children, seam.SeamNode(i, j, energy_map(i, j), parent)];
        end
        
        energy_of_ch = arrayfun(@(x) x.SeamEnergy, temp_children);
        [min_e_ch, index_ch] = min(energy_of_ch);
        
        nodes{i} = temp_children(index_ch);
    end
    
    %now we will reverse the path
    seam_path{img_rows} = nodes{img_rows};
    
    for i = img_rows:-1:2
        seam_path{i - 1} = seam_path{i}.Parent;
    end
    
    out = seam.Seam(seam_path);
end