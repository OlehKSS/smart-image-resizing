%Define an energy function for the imported image
%using the Sobel gradient operator
function f1 = e1_error(image)
    if size(image,3)==3
        image=rgb2gray(image);
    end
    
    [Gx, Gy] = imgradientxy(image);
    f1 = abs(Gx) + abs(Gy);
    %f2 = Gx + Gy;
end
