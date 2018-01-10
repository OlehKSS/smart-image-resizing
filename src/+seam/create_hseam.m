function [out, seams_map] = create_hseam(img, energy_map, seams_map, start_row)
    %creates horizontal seam, seams overlaping will be excluded by usage of
    %seams_map variable
    [img_rows, img_cols, ~] = size(img);
    
    %creating starting seam node
    sm1 = seam.SeamNode(start_row,  1, energy_map(start_row, 1));
    nodes = {img_cols};
    nodes{1} = sm1;
    connectivityCoeff = 1;
    
    %traversing every column starting from second one
    %and creating all possible 8-paths
    for i = 2:img_cols
        parent = nodes{i - 1};
        pixel_selected = false;
        %how many rows from left or from right to check
        number_of_neighbors_to_check = 1;
        
        while (~pixel_selected)
            temp_children = [];
            temp_row_start = parent.Row - number_of_neighbors_to_check;
            temp_row_end = parent.Row + number_of_neighbors_to_check;
            %saving number of members to check
            connectivityCoeff = max(number_of_neighbors_to_check, connectivityCoeff);
                        
            %checking image boundaries and correcting values
            if (temp_row_start < 1)
                temp_row_start = 1;
            end
            if (temp_row_end > img_rows)
                temp_row_end = img_rows;
            end
            
            temp_children_rows = [temp_row_start, parent.Row, temp_row_end];
            
            %here we take every descendent node, it is quicker to
            %take just one with minimum of energy
            for j = 1:length(temp_children_rows)
                temp_row = temp_children_rows(j);
                temp_children = [temp_children, seam.SeamNode(temp_row, i, energy_map(temp_row, i), parent)];
            end
            
            energy_of_ch = arrayfun(@(x) x.SeamEnergy, temp_children);
            [~, indices_ch] = sort(energy_of_ch, 'ascend');
            
            %checking for pixel overlapping, add pixels that are not shared by
            %other seams
            for j = 1:length(indices_ch)
                index_ch = indices_ch(j);
                ch_coords = temp_children(index_ch).get_coords();
                ch_row = ch_coords(1);
                ch_col = ch_coords(2);

                if (seams_map(ch_row, ch_col) ~= 1)
                    nodes{i} = temp_children(index_ch);
                    seams_map(ch_row, ch_col) = 1;
                    pixel_selected = true;
                    break;
                end
            end
            
            number_of_neighbors_to_check = number_of_neighbors_to_check + 1;
            
            if (number_of_neighbors_to_check > img_rows)
                disp(strcat('Out of range for neighbors check:', num2str(number_of_neighbors_to_check)));
            end
        end
    end
    
    %now we will reverse the path
    seam_path{img_cols} = nodes{img_cols};
    
    for i = img_cols:-1:2
        seam_path{i - 1} = seam_path{i}.Parent;
    end
    
    out = seam.Seam(seam_path);
    
    if (connectivityCoeff ~= 1)
        out.is8Connected = false;
        out.connectivityCoeff = connectivityCoeff;
    end
end