%% Atelier 1 - Manipulation des images

clear
clc
close all

%% -----------------------------
% Read the image
%% -----------------------------

F = imread('fleur.png');

figure;
subplot(2,2,1);
imshow(F);
title('Original Image');

%% -----------------------------
% Separate RGB channels
%% -----------------------------

subplot(2,2,2);
imshow(F(:,:,1));
title('Red Component');

subplot(2,2,3);
imshow(F(:,:,2));
title('Green Component');

subplot(2,2,4);
imshow(F(:,:,3));
title('Blue Component');

%% -----------------------------
% Swap Red and Green channels
%% -----------------------------

F2 = F;
F2(:,:,1) = F(:,:,2);   % Replace Red with Green
F2(:,:,2) = F(:,:,1);   % Replace Green with Red

figure;
imshow(F2);
title('Red and Green Swapped');

%% -----------------------------
% Convert to grayscale
%% -----------------------------

G = rgb2gray(F);

figure;
imshow(G);
title('Grayscale Image');

%% -----------------------------
% Spatial downsampling (factor 4)
%% -----------------------------

G_sub = G(1:4:end , 1:4:end);

figure;
imshow(G_sub);
title('Downsampled x4');

%% -----------------------------
% Quantization with N = 2 levels
%% -----------------------------

N = 2;
delta = 256 / N;

G_quant = floor(double(G_sub) / delta) * delta;
G_quant = uint8(G_quant);

figure;
imshow(G_quant,[0 255]);
title('Quantized Image (N = 2)');