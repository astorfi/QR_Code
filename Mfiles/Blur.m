I = im2double(imread('testimage/Qr-perspective-2 - Copy.jpg'));
imshow(I);
title('Original Image (courtesy of MIT)');
LEN = 2;
THETA = 3;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
blurred = imrotate(blurred,50);
figure, imshow(blurred)