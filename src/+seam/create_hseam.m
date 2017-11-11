function out = create_hseam(img, energy_map, start_row)
    [img_rows, img_cols, colors] = size(img);
    
    %creating starting seam node
    sm1 = seam.SeamNode(start_row,  1, energy_map(start_row, 1));
    nodes = {img_cols};
    nodes{1} = sm1;
    
    %traversing every column starting from second one
    %and creating all possible 8-paths
    for i = 2:img_cols
        parent = nodes{i - 1};
        temp_children = [];
        temp_row_start = parent.Row - 1;
        temp_row_end = parent.Row + 1;

        %checking image boundaries and correcting values
        if (temp_row_start < 1)
            temp_row_start = 1;
        end
        if (temp_row_end > img_rows)
            temp_row_end = img_rows;
        end

        %here we take every descendent node, it might be quicker to
        %take just one with minimum of energy
        for j = temp_row_start : temp_row_end
            temp_children = [temp_children, seam.SeamNode(j, i, energy_map(j, i), parent)];
        end
        
        energy_of_ch = arrayfun(@(x) x.SeamEnergy, temp_children);
        [min_e_ch, index_ch] = min(energy_of_ch);
        
        nodes{i} = temp_children(index_ch);
    end
    
    %now we will reverse the path
    seam_path{img_cols} = nodes{img_cols};
    
    for i = img_cols:-1:2
        seam_path{i - 1} = seam_path{i}.Parent;
    end
    
    out = seam.Seam(seam_path);
end