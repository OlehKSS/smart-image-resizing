function out = create_vseams(img, energy_map, number_of_seams)
    %create_hseams(img, energy_map, number_of_seams) - creates number_of_seams
    %of vertical seams and returns its coordinates

    import seam.create_vseam;

    [rows, cols, ~] = size(img);
    
    %this map(mask) is a matrix of pixels selected to create vertical seams
    seams_map = zeros(rows, cols);
    seams_array = {cols};
    seams_energy = zeros(1, cols);
    seams_connectivity = zeros(1, cols);

    for i = 1:cols
        [temp_seam, seams_map] = create_vseam(img, energy_map, seams_map, i);
        
        seams_array{i} = temp_seam;
        seams_energy(i) = temp_seam.Energy;
        seams_connectivity(i) = temp_seam.Energy * temp_seam.connectivityCoeff;
        %this is for us to know that everything alright, cause this thing
        %takes some time to do
        if (mod(i, 100) == 0)
            disp(strcat('Processed columns: ', num2str(i)));
        end
    end
    
    %selects required number of seams with the lowest energy
    [~, vindices] = sort(seams_energy, 'ascend');
    [~, vconect_indices] = sort(seams_connectivity, 'ascend');
    selected_indices = [];
    seams_8connected = [];
    out = [];
    
    for i = 1 : length(vindices)
        temp_seam = seams_array{vindices(i)};
        if (temp_seam.is8Connected)
            seams_8connected = [seams_8connected, temp_seam];
            selected_indices = [selected_indices, vindices(i)];
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
        
        for i = 1 : length(vconect_indices)
            if (~ismember(vconect_indices(i), selected_indices))
                %take not selected before seams
                temp_seam = seams_array{vconect_indices(i)};
                out = [out, temp_seam];
            end
            
            if (length(out) == number_of_seams)
                %found enough good seams, no need to proceeed
                break;
            end
        end
    end
end