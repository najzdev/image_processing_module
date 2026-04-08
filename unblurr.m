% 1. Load the image (ensure filename is correct)
img = double(imread('runaway.jpg')) / 255;
[h, w, c] = size(img);

% 2. Create a high-density grid for smoothing
scale = 4; % Upscale by 4x to melt the pixel blocks
[X, Y] = meshgrid(1:w, 1:h);
[Xq, Yq] = meshgrid(1:1/scale:w, 1:1/scale:h);

% 3. Apply Linear Interpolation to every color channel
% This 'stretches' the single-color blocks into smooth gradients
restored = zeros(size(Xq,1), size(Xq,2), c);
for i = 1:c
    restored(:,:,i) = interp2(X, Y, img(:,:,i), Xq, Yq, 'linear');
end

% 4. Manual High-Pass Filter (To fake "sharpness")
% We subtract a blurred version from the original to find edges
blur_kernel = ones(7)/49;
low_freq = zeros(size(restored));
for i = 1:c
    low_freq(:,:,i) = conv2(restored(:,:,i), blur_kernel, 'same');
end
% Amplify the difference (high frequencies)
final_img = restored + (restored - low_freq) * 1.5; 

% 5. Final output
final_img = max(0, min(1, final_img)); % Clip to valid range
imshow(final_img);
title('Mathematical Smoothing (Maximum Restoration Possible)');
imwrite(final_img, 'unblurred_attempt.png');