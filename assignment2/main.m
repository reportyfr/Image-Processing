%clear environment and command line
clear;
clc;
%choose the image
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif';}, 'please choose the image');

%if no images are picked, then the function returns
if filename == 0
    return;
end

%read the image
imgsrc = imread([pathname, filename]);
[y, x, dim] = size(imgsrc);

%transfer the source image into grey-scale image if necessary
if dim>1
    imgsrc = rgb2gray(imgsrc);
end

%define the sigma value of gaussian 
sigma = 1.6;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');
double(img);

%define low threshold and high threshold
lowTh = 30;
highTh = 50;

%
[m, theta, sector, canny1,  canny2] = canny_algorithm(img, lowTh, highTh);
figure(1)
    subplot(2,2,1);
        imshow(imgsrc);%original image
    subplot(2,2,2);
        imshow(img);%after smoothing
    subplot(2,2,3);
        imshow(uint8(canny1));%after nonmax_suppression
    subplot(2,2,4);
        imshow(uint8(canny2));%after hysteresis
