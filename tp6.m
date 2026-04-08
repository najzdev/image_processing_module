%% Digital Image Processing Workshop: Spatial Filtering
% This script implements noise addition and filtering as per the exercise.

clear; clc; close all;

% 1. Load the original image
% Replace 'flower.jpg' with the actual path to your image
I = imread('2.png'); 
I_gray = rgb2gray(I); % Converting to grayscale for standard filter processing
I_double = im2double(I_gray);

%% --- PART 1: Salt and Pepper Noise & Non-Linear Filters ---

% 1) Add Salt and Pepper Noise
I_sp = imnoise(I_gray, 'salt & pepper', 0.05);

% 2) Median Filter (Excellent for Salt and Pepper)
I_median = medfilt2(I_sp, [3 3]);

% 3) Minimum Filter (Erosion - replaces pixel with darkest in neighborhood)
I_min = ordfilt2(I_sp, 1, ones(3, 3));

% 4) Maximum Filter (Dilation - replaces pixel with brightest in neighborhood)
I_max = ordfilt2(I_sp, 9, ones(3, 3));

%% --- PART 2: Gaussian Noise & Linear Smoothing Filters ---

% 5) Add Gaussian Noise
I_gaussian_noisy = imnoise(I_gray, 'gaussian', 0, 0.01);

% 6) Mean/Box Filter (Average Filter)
h_mean = fspecial('average', [3 3]);
I_mean = imfilter(I_gaussian_noisy, h_mean);

% 7) Gaussian Filter (sigma = 1)
% Using the specific kernel provided in your document:
% [1 2 1; 2 4 2; 1 2 1] / 16
h_gauss = [1 2 1; 2 4 2; 1 2 1] / 16;
I_gauss_filtered = imfilter(I_gaussian_noisy, h_gauss);

%% --- Visualization ---

% Plotting Salt & Pepper Results
figure('Name', 'Salt & Pepper Noise and Restoration');
subplot(2,2,1); imshow(I_sp); title('1) Salt & Pepper Noise');
subplot(2,2,2); imshow(I_median); title('2) Median Filter');
subplot(2,2,3); imshow(I_min); title('3) Minimum Filter');
subplot(2,2,4); imshow(I_max); title('4) Maximum Filter');

% Plotting Gaussian Results
figure('Name', 'Gaussian Noise and Smoothing');
subplot(2,2,1); imshow(I_gaussian_noisy); title('5) Gaussian Noise');
subplot(2,2,2); imshow(I_mean); title('6) Mean (Box) Filter');
subplot(2,2,3); imshow(I_gauss_filtered); title('7) Gaussian Filter (\sigma=1)');

% Note on Gaussian Formula
% The formula provided in the document is:
% G(x,y) = (1 / (2*pi*sigma^2)) * exp(-(x^2 + y^2) / (2*sigma^2))