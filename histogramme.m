% Workshop: Histogram Equalization and Analysis
% 8-bit Grayscale Image Processing

clc; clear; close all;

%% 0. Define the Image Matrix I (8x8)
I = [52 51 61 59 70 61 70 61;
     62 59 55 104 94 85 59 71;
     63 65 66 113 144 104 63 72;
     64 70 76 126 154 109 71 69;
     67 72 68 106 122 88 68 68;
     68 75 60 78 77 66 58 75;
     69 85 64 58 55 61 65 83;
     70 87 69 60 61 65 74 90];

I_uint8 = uint8(I); % Convert to uint8 for standard processing
[rows, cols] = size(I);
N = rows * cols;

%% 1) Mean Luminance
mean_luminance = sum(I(:)) / N;

%% 2) Dynamic Range [Lmin, Lmax]
Lmin = min(I(:));
Lmax = max(I(:));

%% 3) Image Contrast
contrast = Lmax - Lmin;

%% 4) Standard Deviation
% Standard deviation of pixel intensities
std_dev = std(double(I(:)));

% Display results for Part 1
fprintf('--- Initial Analysis ---\n');
fprintf('Mean Luminance: %.2f\n', mean_luminance);
fprintf('Dynamic Range: [%d, %d]\n', Lmin, Lmax);
fprintf('Contrast: %d\n', contrast);
fprintf('Standard Deviation: %.2f\n\n', std_dev);

%% 5) & 6) Histograms and Cumulative Histograms
% Range is 0 to 255
hist_counts = zeros(1, 256);
for val = 0:255
    hist_counts(val+1) = sum(I(:) == val);
end

% Normalized Histogram (Probability Density Function)
pdf = hist_counts / N;

% Cumulative Histogram
C = cumsum(hist_counts);

% Normalized Cumulative Histogram
Cn = cumsum(pdf);

%% 7) Histogram Equalization
% Formula: F'(x,y) = [(Cn(F(x,y)) - min(Cn)) / (max(Cn) - min(Cn))] * 255
Cn_min = min(Cn(Cn > 0)); % Minimum non-zero cumulative probability
Cn_max = max(Cn);

I_equalized = zeros(rows, cols);
for r = 1:rows
    for c = 1:cols
        pixel_val = I(r,c);
        % Apply the formula from the PDF
        I_equalized(r,c) = ((Cn(pixel_val+1) - Cn_min) / (Cn_max - Cn_min)) * 255;
    end
end
I_equalized = uint8(I_equalized);

%% Travail Personnel: Contrast Stretching (Expansion de la dynamique)
% Formula: I' = [(I - Lmin) / (Lmax - Lmin)] * 255
I_stretched = ((double(I) - Lmin) / (Lmax - Lmin)) * 255;
I_stretched = uint8(I_stretched);

%% 8) Visualization and Comparison
figure('Name', 'Image Processing Results');

% Original Image and Histogram
subplot(3,2,1); imshow(I_uint8, []); title('Original Image');
subplot(3,2,2); bar(0:255, hist_counts); title('Original Histogram'); xlim([0 255]);

% Equalized Image and Histogram
subplot(3,2,3); imshow(I_equalized); title('Equalized (Non-linear)');
subplot(3,2,4); imhist(I_equalized); title('Equalized Histogram');

% Stretched Image and Histogram
subplot(3,2,5); imshow(I_stretched); title('Stretched (Linear)');
subplot(3,2,6); imhist(I_stretched); title('Stretched Histogram');

% Print Comparison Summary
fprintf('--- Comparison ---\n');
fprintf('Original Range: [%d, %d]\n', Lmin, Lmax);
fprintf('Stretched Range: [%d, %d]\n', min(I_stretched(:)), max(I_stretched(:)));
fprintf('Equalized Range: [%d, %d]\n', min(I_equalized(:)), max(I_equalized(:)));

% Linear Stretching
I_stretched = ((double(I) - Lmin) / (Lmax - Lmin)) * 255;
I_stretched = uint8(I_stretched);

% Comparison Display
figure;
subplot(1,2,1); imshow(I_equalized); title('After Equalization (Fig 1)');
subplot(1,2,2); imshow(I_stretched); title('After Stretching');