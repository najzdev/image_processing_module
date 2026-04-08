% AmaneAI: Final Unified Agricultural Intelligence Script
% Version 3.0 - Maximum Compatibility & Full Feature Set
% -----------------------------------------------------------------------

clear; clc; close all;

% 1. LOAD IMAGE
try
    img = imread('farm_drone.jpg'); % Ensure your file is named exactly this
    img_double = im2double(img);
catch
    error('Image file not found. Ensure "farm_drone.jpg" is in your current MATLAB folder.');
end

% 2. CALC VEGETATION INDEX (VARI)
R = img_double(:,:,1);
G = img_double(:,:,2);
B = img_double(:,:,3);
VARI = (G - R) ./ (G + R - B + eps);

% 3. K-MEANS SEGMENTATION (LAND CLASSES)
[rows, cols, channels] = size(img_double);
pixel_data = reshape(img_double, rows*cols, channels);
nClusters = 3; 
[cluster_idx, ~] = kmeans(pixel_data, nClusters, 'Distance', 'sqEuclidean', 'Replicates', 3);
segmented_img = reshape(cluster_idx, rows, cols);

% Find Crop Cluster
avg_green = zeros(nClusters, 1);
for i = 1:nClusters
    avg_green(i) = mean(G(segmented_img == i));
end
[~, crop_cluster_id] = max(avg_green);
crop_mask = (segmented_img == crop_cluster_id);

% 4. STRUCTURAL ANALYSIS (ROW DETECTION)
binary_crops = bwareaopen(crop_mask, 50); 
se = strel('disk', 3);
row_structure = imclose(binary_crops, se);
projection = sum(row_structure, 1);

% 5. WATER STRESS DETECTION (AI LOGIC)
health_threshold = 0.12; 
stressed_mask = (VARI < health_threshold) & crop_mask;
stressed_mask = bwareaopen(stressed_mask, 15); 
[row_coord, col_coord] = find(stressed_mask);

% 6. AMANE-AI WATER ESTIMATOR (NEW FEATURE)
% Assuming 1 pixel = 0.1 meters (adjust based on drone altitude)
pixel_size_meters = 0.1; 
stressed_area_m2 = sum(stressed_mask(:)) * (pixel_size_meters^2);
% Assuming 5 liters per m2 for irrigation
liters_needed = stressed_area_m2 * 5; 

% 7. DISPLAY ALL FIGURES (6 Visualizations)
figure('Name', 'AmaneAI Agricultural Intelligence');

subplot(2,3,1); imshow(img); title('1. Raw Drone Image');
subplot(2,3,2); imagesc(VARI); colormap(gca, 'jet'); colorbar; title('2. Health Index (VARI)');
subplot(2,3,3); imshow(segmented_img, []); colormap(gca, 'hsv'); title('3. Land Classification');
subplot(2,3,4); imshow(row_structure); title('4. Isolated Crop Rows');
subplot(2,3,5); plot(projection, 'g'); grid on; title('5. Row Density Plot');
subplot(2,3,6); imshow(img); hold on; plot(col_coord, row_coord, 'r.', 'MarkerSize', 1); 
title('6. Targeted Irrigation Map');

% 8. DATA EXPORT (JSON for Node.js/IoT)
report = struct();
report.project = 'AmaneAI';
report.crop_coverage_pct = (sum(crop_mask(:)) / numel(crop_mask)) * 100;
report.stress_pct = (sum(stressed_mask(:)) / sum(crop_mask(:))) * 100;
report.estimated_liters = liters_needed;
report.coords = [col_coord(1:20:end), row_coord(1:20:end)]; % Sampled for light JSON

jsonData = jsonencode(report);
fid = fopen('amane_report.json', 'w');
fprintf(fid, '%s', jsonData);
fclose(fid);

% PRINT REPORT
fprintf('\n--- AMANE-AI ANALYTICS REPORT ---\n');
fprintf('Active Crop Coverage: %.2f%%\n', report.crop_coverage_pct);
fprintf('Water Stress Level:   %.2f%%\n', report.stress_pct);
fprintf('Water Needed:         %.1f Liters\n', liters_needed);
fprintf('JSON Data Saved:      amane_report.json\n');
fprintf('---------------------------------\n');