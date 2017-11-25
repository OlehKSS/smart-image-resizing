function detect = hog(im)

    %hog = hog_feature_vector (im);
    im =imread('football.jpg');
   imshow(im);
   %  imshow(im3);
% Convert RGB iamge to grayscale
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

%gauss= fspecial('gaussian',25000); %% Initialized a gaussian filter with sigma=0.5 * block width.    

angle=atand(Ix./Iy); % Matrix containing the angles of each edge gradient
angle=imadd(angle,90); %Angles in range (0,180)

magnitude=sqrt(Ix.^2 + Iy.^2);

[pixelCounts, GrayLevels] = imhist(magnitude);
   maxGrayLevel = max(magnitude(3));


hogy = magnitude/maxGrayLevel;
%hogy = magnitude/max(histogram(magnitude,'pdf',NM);
%[featurevec,hogvisualization]=extractHOGFeatures(magnitude);

 %figure,imshow(uint8(angle));
 figure,imshow(uint8(hogy));
 %hold on;
 %plot(hogvisualization);

end