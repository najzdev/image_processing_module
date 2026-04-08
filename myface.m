clc
clear
close all

%% -----------------------------
% Load your face image
%% -----------------------------
Im_01 = imread('myface.jpeg');  % Replace with your face image file
if size(Im_01,3) == 3          % Convert to grayscale if RGB
    Im_01 = rgb2gray(Im_01);
end

%% -----------------------------
% Resize factor (for better screenshots)
%% -----------------------------
scale = 2;  % Adjust depending on your image size

%% -----------------------------
% Display original image
%% -----------------------------
figure
imshow(imresize(Im_01,scale))
title('Original Face Image')

%% -----------------------------
% Height and width
%% -----------------------------
[height,width] = size(Im_01);

disp('Height:')
disp(height)

disp('Width:')
disp(width)

%% -----------------------------
% Number of bits needed (8-bit image)
%% -----------------------------
bits = height * width * 8;
disp('Number of bits required:')
disp(bits)

%% -----------------------------
% Create modified image Im_02
% Example: black out a small patch in the center
%% -----------------------------
Im_02 = Im_01;
patch_size = 20; % size of patch
center_row = round(height/2);
center_col = round(width/2);
Im_02(center_row-patch_size:center_row+patch_size, ...
      center_col-patch_size:center_col+patch_size) = 0;

figure
imshow(imresize(Im_02,scale))
title('Modified Face Image')

%% -----------------------------
% Detect modification using subtraction
%% -----------------------------
Diff = Im_01 - Im_02;

figure
imshow(imresize(Diff,scale),[])
title('Difference Image')

%% -----------------------------
% Increase luminance (brightness)
%% -----------------------------
Bright = Im_01 + 50;   % brighten by adding 50
Bright(Bright>255) = 255;  % clip max value to 255

figure
imshow(imresize(Bright,scale),[])
title('Increased Luminance')

%% -----------------------------
% Improve contrast
%% -----------------------------
Contrast = Im_01 * 1.5; 
Contrast(Contrast>255) = 255;  % clip max value

figure
imshow(imresize(Contrast,scale),[])
title('Improved Contrast')