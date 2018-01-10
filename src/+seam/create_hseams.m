function out = create_hseams(img, energy_map, number_of_seams)
    %create_hseams(img, energy_map, number_of_seams) - creates number_of_seams
    %of horizontal seams and returns its coordinates

    import seam.create_hseam;

    [rows, cols, ~] = size(img);

    %this map(mask) is a matrix of pixels selected to create horizontal seams
    seams_map = zeros(rows, cols);
    seams_array = {rows};
    seams_energy = zeros(1, rows);
    seams_connectivity = zeros(1, rows);
    
    for i = 1:rows
        [temp_seam, seams_map] = create_hseam(img, energy_map, seams_map, i);
        
        seams_array{i} = temp_seam;
        seams_energy(i) = temp_seam.Energy;
        seams_connectivity(i) = temp_seam.Energy * temp_seam.connectivityCoeff;
        
        %this is for us to know that everything alright, cause this thing
        %takes some time to do
        if (mod(i, 100) == 0)
            disp(strcat('Processed rows: ', num2str(i)));
        end
    end
    
    %selects required number of seams with the lowest energy
    [~, hindices] = sort(seams_energy, 'ascend');
    [~, hconect_indices] = sort(seams_connectivity, 'ascend');
    selected_indices = [];
    seams_8connected = [];
    out = [];
    
    for i = 1 : length(hindices)
        temp_seam = seams_array{hindices(i)};
        if (temp_seam.is8Connected)
            seams_8connected = [seams_8connected, temp_seam];
            selected_indices = [selected_indices, hindices(i)];
        end
        
        if (length(seams_8connected) == number_of_seams)
            %found enough good seams, no need to proceeed
            break;
        end
    end
    
    if (length(seams_8connected) == number_of_seams)
        out = seams_8connected;
    else
        %take disconnected seams if not enough 8-connected seams available
        out = seams_8connected;
        
        for i = 1 : length(hconect_indices)
            if (~ismember(hconect_indices(i), selected_indices))
                %take not selected before seams
                temp_seam = seams_array{hconect_indices(i)};
                out = [out, temp_seam];
            end
            
            if (length(out) == number_of_seams)
                %found enough good seams, no need to proceeed
                break;
            end
        end
    end
end