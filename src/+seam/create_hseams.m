function out = create_hseams(img, energy_map, number_of_seams)
    %create_hseams(img, energy_map, number_of_seams) - creates number_of_seams
    %of horizontal seams and returns its coordinates

    import seam.create_hseam;

    [rows, cols, ~] = size(img);

    %this map(mask) is a matrix of pixels selected to create horizontal seams
    seams_map = zeros(rows, cols);
    seams_array = {rows};
    seams_energy = zeros(1, rows);
    
    for i = 1:rows
        [temp_seam, seams_map] = create_hseam(img, energy_map, seams_map, i);
        
        seams_array{i} = temp_seam;
        seams_energy(i) = temp_seam.Energy;
        
        %this is for us to know that everything alright, cause this thing
        %takes some time to do
        if (mod(i, 100) == 0)
            disp(strcat('Processed rows: ', num2str(i)));
        end
    end
    
    %selects required number of seams with the lowest energy
    [~, hindices] = sort(seams_energy, 'ascend');
    out = [];
    
    for i = 1 : number_of_seams
        out = [out, seams_array{hindices(i)}];
    end
end