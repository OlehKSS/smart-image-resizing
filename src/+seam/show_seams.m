function show_seams(img, marray, narray, color)
    [~, ~, levels] = size(img);
    
    if (levels == 1)
        for i = 1:length(marray)
            img(marray(i), narray(i)) = color;
        end
    else
        for i = 1:length(marray)
            img(marray(i), narray(i), :) = [color 0 0];
        end
    end
    
    imshow(img, []);
end

