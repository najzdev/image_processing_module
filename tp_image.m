%% TP - Image Processing (Exercise 1)

clc
clear
close all

%% Image matrix Im_01
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
title('Image Im\_01')

%% 1) Mean of matrix
mean_value = mean(Im_01(:));
disp('Mean of matrix:')
disp(mean_value)

%% 2) Distances between A,B and A,C
A = [8 8];
B = [4 7];
C = [8 5];

% Euclidean distance
dist_AB_euclid = sqrt(sum((A-B).^2));
dist_AC_euclid = sqrt(sum((A-C).^2));

% Manhattan distance
dist_AB_manhattan = sum(abs(A-B));
dist_AC_manhattan = sum(abs(A-C));

disp('Euclidean Distance A-B:')
disp(dist_AB_euclid)

disp('Euclidean Distance A-C:')
disp(dist_AC_euclid)

disp('Manhattan Distance A-B:')
disp(dist_AB_manhattan)

disp('Manhattan Distance A-C:')
disp(dist_AC_manhattan)

%% 3) Pixel value p = f(5,3)
p = Im_01(5,3);
disp('Pixel value p = f(5,3):')
disp(p)

%% 4) Mean of 3x3 neighbors of p
neighbors = Im_01(4:6,2:4);
mean_neighbors = mean(neighbors(:));

disp('Mean of 3x3 neighbors:')
disp(mean_neighbors)

%% 5) Median of 3x3 neighbors
median_neighbors = median(neighbors(:));

disp('Median of 3x3 neighbors:')
disp(median_neighbors)