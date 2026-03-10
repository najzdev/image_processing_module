clc
clear
close all

%% Create image from matrix (Im_01)
Im_01 = [
255 255 255 110 110 110 110 110 110 255 255 255;
255 255 255 110 110 110 110 110 110 255 255 255;
255 255 255 110 110 110 110 110 110 255 255 255;
255 110 110 110 110 110 110 110 110 110 110 255;
255 255 255 170 170 170 170 170 170 255 255 255;
255 255 255 170 170 170 170 170 170 255 255 255;
255 255 255 170 10 170 170 10 170 255 255 255;
255 255 255 170 170 170 170 170 170 255 255 255;
255 255 255 255 170 80 80 170 255 255 255 255;
255 255 255 255 170 170 170 170 255 255 255 255;
255 255 255 255 255 255 255 255 255 255 255 255
];

%% Display image
figure
imshow(Im_01,[0 255])
title('Image Im_01')

%% Height and width
[height,width] = size(Im_01);

disp('Height:')
disp(height)

disp('Width:')
disp(width)

%% Number of bits
bits = height * width * 8;

disp('Bits required:')
disp(bits)

%% Create modified image Im_02
Im_02 = Im_01;
Im_02(7:9,3:5) = 0;

figure
imshow(Im_02,[0 255])
title('Image Im_02')

%% Detect modification
Diff = Im_01 - Im_02;

figure
imshow(Diff,[])
title('Difference Image')

%% Increase luminance
Bright = Im_01 + Im_01;

figure
imshow(Bright,[])
title('Brightness Increased')

%% Improve contrast
Contrast = Im_01 * 1.5;

figure
imshow(Contrast,[])
title('Contrast Improved')