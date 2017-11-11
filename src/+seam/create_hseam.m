function out = create_hseam(img, energy_map, start_row)
    [img_rows, img_cols] = size(img);
    
    %creating starting seam node
    sm1 = seam.SeamNode(start_row,  1, energy_map(start_row, 1));
    nodes = {img_cols};
    nodes{1} = [sm1];
    
    %traversing every column starting from second one
    %and creating all possible 8-paths
    for i = 2:img_cols
        parents = nodes{i -1};
        temp_children = [];
        
        for p = 1:length(parents)
            temp_row_start = parents(p).Column - (i - 1);
            temp_row_end = parents(p).Column + (i - 1);

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
                temp_children = [temp_children, seam.SeamNode(j, i, energy_map(j, i), parents(p))];
            end
        end
        
        nodes{i} = temp_children;
    end
    
    energy_of_seams = arrayfun(@(x) x.SeamEnergy, nodes{img_cols});
    [min_e, index] = min(energy_of_seams);
    seam_path{img_cols} = nodes{img_cols}(index);
    
    for i = img_cols:-1:2
        seam_path{i - 1} = seam_path{i}.Parent;
    end
    
    out = seam.Seam(seam_path);
end