function detect = hog(im)
%from rgb to grayscale ,,,i think it is better to embed both energy fn ,,
%and choose e1 for grayscale and hog for RGB because e1 has very good
%results on Grayscale,,, and hog has very good results on RGB image.
if size(im,3)==3
 im=rgb2gray(im);
end
im=double(im);
rows=size(im,1);
cols=size(im,2);
Ix=im; %Basic Matrix assignment
Iy=im; %Basic Matrix assignment

% Gradients in X and Y direction. Iy is the gradient in X direction and Iy
% is the gradient in Y direction
for i=1:rows-2
    Iy(i,:)=(im(i,:)-im(i+2,:));
end
for i=1:cols-2
    Ix(:,i)=(im(:,i)-im(:,i+2));
end


magnitude=sqrt(Ix.^2 + Iy.^2);

   GrayLevels = max(magnitude(3));


hogy = magnitude/GrayLevels;
%hogy = magnitude/max(histogram(magnitude,'pdf',NM);

%figure,imshow(uint8(angle));
    detect = hogy;


end