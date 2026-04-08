clear all; close all; clc;

A = [0 0 1 0 0;
     0 1 1 1 0;
     1 1 1 1 1;
     0 1 1 1 0;
     0 0 1 0 0];

B = [1 1 1;
     1 1 1;
     1 1 1];

disp('Image A:');
disp(A);
disp('Structuring Element B:');
disp(B);

A_erode = imerode(A, B);
disp('Erosion (A ? B):');
disp(A_erode);

A_dilate = imdilate(A, B);
disp('Dilation (A ? B):');
disp(A_dilate);

A_contour = A - A_erode;
disp('Morphological Contour ?(A) = A - (A ? B):');
disp(A_contour);

figure('Name', 'Morphological Operations', 'NumberTitle', 'off');
subplot(2,2,1), imshow(A, []), title('Original Image A'), colormap(gray(256));
subplot(2,2,2), imshow(A_erode, []), title('Erosion (A ? B)'), colormap(gray(256));
subplot(2,2,3), imshow(A_dilate, []), title('Dilation (A ? B)'), colormap(gray(256));
subplot(2,2,4), imshow(A_contour, []), title('Morphological Contour'), colormap(gray(256));

test_image = imread('Remplissage.png');

if size(test_image, 3) == 3
    test_image = rgb2gray(test_image);
end

test_image = im2double(test_image);

Sobel_X = [-1  0  1;
           -2  0  2;
           -1  0  1];

Sobel_Y = [-1 -2 -1;
            0  0  0;
            1  2  1];

Gx = convn(test_image, Sobel_X, 'same');
Gy = convn(test_image, Sobel_Y, 'same');

disp('Sobel Gradient Gx calculated');
disp('Sobel Gradient Gy calculated');

G = sqrt(Gx.^2 + Gy.^2);

G_normalized = (G - min(G(:))) / (max(G(:)) - min(G(:)));

disp('Gradient Magnitude calculated');

threshold = graythresh(G_normalized) * max(G(:));

disp(['Threshold value: ', num2str(threshold)]);

edges_binary = G > threshold;

edges_thinned = bwmorph(edges_binary, 'thin', inf);

figure('Name', 'Sobel Edge Detection', 'NumberTitle', 'off');
set(gcf, 'Position', [100 100 1400 900]);

subplot(2,3,1), imshow(test_image, []), title('Original Image'), colormap(gray(256));
subplot(2,3,2), imshow(abs(Gx), []), title('Gradient Gx'), colormap(gray(256));
subplot(2,3,3), imshow(abs(Gy), []), title('Gradient Gy'), colormap(gray(256));
subplot(2,3,4), imshow(G_normalized, []), title('Magnitude G (normalized)'), colormap(gray(256));
subplot(2,3,5), imshow(edges_binary, []), title('Binary Edges'), colormap(gray(256));
subplot(2,3,6), imshow(edges_thinned, []), title('Thinned Edges'), colormap(gray(256));

image_binary = test_image > 0.5;

image_filled = imfill(image_binary, 'holes');

SE = strel('disk', 3);
image_opened = imopen(image_binary, SE);
image_closed = imclose(image_opened, SE);

image_filled_smooth = imfill(image_closed, 'holes');

figure('Name', 'Hole Filling', 'NumberTitle', 'off');
set(gcf, 'Position', [100 100 1400 900]);

subplot(2,3,1), imshow(image_binary, []), title('Original Binary'), colormap(gray(256));
subplot(2,3,2), imshow(image_filled, []), title('Holes Filled'), colormap(gray(256));
subplot(2,3,3), imshow(image_opened, []), title('Opening'), colormap(gray(256));
subplot(2,3,4), imshow(image_closed, []), title('Closing'), colormap(gray(256));
subplot(2,3,5), imshow(image_filled_smooth, []), title('Filled + Smoothed'), colormap(gray(256));
subplot(2,3,6), imshow(~image_binary, []), title('Inverted (Holes)'), colormap(gray(256));

disp('All operations completed!');