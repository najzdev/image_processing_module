clc;
clear;
close all;

%% -----------------------------
% 1?? Load your face image
%% -----------------------------
Im = imread('myface.jpeg');   % Replace with your image file
if size(Im,3) == 3           % Convert to grayscale if RGB
    Im = rgb2gray(Im);
end

%% -----------------------------
% 2?? Resize image to small matrix
% Example: 12 rows x 13 columns like your report example
%% -----------------------------
rows = 12;
cols = 13;
Im_small = imresize(Im, [rows cols]);

%% -----------------------------
% 3?? Round pixel values
%% -----------------------------
Im_small = round(Im_small);

%% -----------------------------
% 4?? Display the matrix in MATLAB
%% -----------------------------
disp('Your image as a matrix of grayscale values:');
disp(Im_small);

%% -----------------------------
% 5?? Save matrix in report-friendly format
% Each row as space-separated values
%% -----------------------------
fileID = fopen('FaceMatrix.txt','w');  % open file
for r = 1:size(Im_small,1)
    fprintf(fileID, '%d ', Im_small(r,:));  % print row values with space
    fprintf(fileID, '\n');                  % new line after each row
end
fclose(fileID);
disp('Matrix saved to FaceMatrix.txt in report-friendly format');

%% -----------------------------
% 6?? Optional: visualize small image
%% -----------------------------
figure;
imshow(Im_small, [0 255]);
title('Small version of your face image');