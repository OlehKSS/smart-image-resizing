%Define an energy function for the imported image
%using the Sobel gradient operator
function f1 = e1_error(image)
    [Gx, Gy] = imgradientxy(image);
    f1 = abs(Gx) + abs(Gy);
    %f2 = Gx + Gy;
end
