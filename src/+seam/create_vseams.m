function out = create_vseams(img, energy_map, number_of_seams)
    %create_hseams(img, energy_map, number_of_seams) - creates number_of_seams
    %of vertical seams and returns its coordinates

    import seam.create_vseam;

    [rows, cols, ~] = size(img);
    
    %this map(mask) is a matrix of pixels selected to create vertical seams
    seams_map = zeros(rows, cols);
    seams_array = {cols};
    seams_energy = zeros(1, cols);

    for i = 1:cols
        [temp_seam, seams_map] = create_vseam(img, energy_map, seams_map, i);
        
        seams_array{i} = temp_seam;
        seams_energy(i) = temp_seam.Energy;
        %this is for us to know that everything alright, cause this thing
        %takes some time to do
        if (mod(i, 100) == 0)
            disp(strcat('Processed columns: ', num2str(i)));
        end
    end
    
    %selects required number of seams with the lowest energy
    [~, vindices] = sort(seams_energy, 'ascend');
    out = [];
    
    for i = 1 : number_of_seams
        out = [out, seams_array{vindices(i)}];
    end
end