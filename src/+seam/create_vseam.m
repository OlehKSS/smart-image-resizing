function [out, seams_map] = create_vseam(img, energy_map, seams_map, start_col)
    %creates vertical seam, seams overlaping will be excluded by usage of
    %seams_map variable
    [img_rows, img_cols, ~] = size(img);
    
    %creating starting seam node
    sm1 = seam.SeamNode(1, start_col, energy_map(1, start_col));
    nodes = {img_rows};
    nodes{1} = sm1;
    connectivityCoeff = 1;
    
    %traversing every row starting from second one
    %and creating all possible 8-paths
    for i = 2:img_rows
        parent = nodes{i - 1};
        pixel_selected = false;
        %how many columns from left or from right to check
        number_of_neighbors_to_check = 1;
        
        %repeat this until next pixel will be found
        while (~pixel_selected)
            temp_children = [];
            temp_col_start = parent.Column - number_of_neighbors_to_check;
            temp_col_end = parent.Column + number_of_neighbors_to_check;
            
            %saving number of members to check
            connectivityCoeff = max(number_of_neighbors_to_check, connectivityCoeff);

            %checking image boundaries and correcting values
            if (temp_col_start < 1)
                temp_col_start = 1;
            end
            if (temp_col_end > img_cols)
                temp_col_end = img_cols;
            end
            
            temp_children_coords = [temp_col_start, parent.Column, temp_col_end];
            for j = 1:length(temp_children_coords)
                temp_coord = temp_children_coords(j);
                temp_children = [temp_children, seam.SeamNode(i, temp_coord, energy_map(i, temp_coord), parent)];
            end
            
            energy_of_ch = arrayfun(@(x) x.SeamEnergy, temp_children);
            %[min_e_ch, index_ch] = min(energy_of_ch);
            [~, indices_ch] = sort(energy_of_ch, 'ascend');

        
            %checking for pixel overlapping, add pixels that are not shared by
            %other seams
            %flag for checking whether we successfully found next pixel for
            %seam

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
            
            if (number_of_neighbors_to_check > img_cols)
                disp(strcat('Out of range for neighbors check:', num2str(number_of_neighbors_to_check)));
            end
        end
    end
    
    %now we will reverse the path
    seam_path{img_rows} = nodes{img_rows};
    
    for i = img_rows:-1:2
        seam_path{i - 1} = seam_path{i}.Parent;
    end
    
    %disp(strcat('done for column ', num2str(start_col)));
    out = seam.Seam(seam_path);
    
    if (connectivityCoeff ~= 1)
        out.is8Connected = false;
        out.connectivityCoeff = connectivityCoeff;
    end
end