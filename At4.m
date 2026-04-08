%% Atelier 4 : Transformation de l'image
% Pr: Y. AIT LAHCEN - Module : Traitement d'Image

clc; clear; close all;

%% ========================================================
%% SECTION 1 : Transformations d intensites (image fleur)
%% ========================================================

try
    fleur = imread('2.png');
catch
    fleur = imread('cameraman.tif');
end

if size(fleur, 3) == 3
    fleur_gray = rgb2gray(fleur);
else
    fleur_gray = fleur;
end
fleur_gray = double(fleur_gray);

figure('Name', 'Section 1 - Transformations d intensites', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Section 1 : Transformations d intensites', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% --- 1) Seuillage
seuil = 127;
fleur_seuil = uint8(fleur_gray > seuil) * 255;

subplot(2,3,1);
imshow(uint8(fleur_gray));
title('Image originale');

subplot(2,3,2);
imshow(fleur_seuil);
title('Seuillage (s=127)');

subplot(2,3,3);
imhist(fleur_seuil);
title('Histogramme - Seuillage');

% --- 2) Etirement de contraste
f_min = min(fleur_gray(:));
f_max = max(fleur_gray(:));
fleur_etirement = uint8(255 * (fleur_gray - f_min) / (f_max - f_min));

subplot(2,3,4);
imshow(fleur_etirement);
title('Etirement de contraste');

subplot(2,3,5);
imhist(fleur_etirement);
title('Histogramme - Etirement');

% --- 3) Transformation logarithmique
c = 255 / log(1 + max(fleur_gray(:)));
fleur_log = uint8(c * log(1 + fleur_gray));

subplot(2,3,6);
imshow(fleur_log);
title('Transformation logarithmique');

%% ========================================================
%% SECTION 2 : Histogramme egalisation et Transformation
%% ========================================================

%% --- Exercice 1 & 2 : Lire color-img.png, convertir en gris

try
    color_img = imread('4.png');
catch
    color_img = imread('peppers.png');
    warning('color-img.png non trouvee. Utilisation de peppers.png.');
end

if size(color_img, 3) == 3
    gray_img = rgb2gray(color_img);
else
    gray_img = color_img;
end

figure('Name', 'Exercice 1 et 2', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Exercice 1 & 2 : Image couleur et niveau de gris', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

subplot(1,2,1);
imshow(color_img);
title('Image couleur originale');

subplot(1,2,2);
imshow(gray_img);
title('Image en niveau de gris [0, 255]');
colorbar;

fprintf('Valeur min: %d | Valeur max: %d\n', min(gray_img(:)), max(gray_img(:)));

%% --- Exercice 3 : Transformation g(x,y) = sqrt(f(x,y))

f = double(gray_img);
g = sqrt(f);
g_normalized = uint8(255 * g / max(g(:)));

figure('Name', 'Exercice 3 - Transformation sqrt', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Exercice 3 : Transformation g(x,y) = sqrt(f(x,y))', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

subplot(1,2,1);
imshow(gray_img);
title('Avant transformation : f(x,y)');

subplot(1,2,2);
imshow(g_normalized);
title('Apres transformation : g(x,y) = sqrt(f(x,y))');

%% --- Exercice 4 : Binarisation avec seuil s = 127

seuil_bin = 127;
binary_img = imbinarize(gray_img, seuil_bin / 255);

figure('Name', 'Exercice 4 - Image binaire', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Exercice 4 : Binarisation avec seuil s = 127', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

subplot(1,2,1);
imshow(gray_img);
title('Image en niveaux de gris');

subplot(1,2,2);
imshow(binary_img);
title('Image binaire (seuil = 127)');

%% --- Exercice 5 : Histogramme de la petite image 5x5

small_img = [0 1 1 1 0;
             1 3 3 2 1;
             1 3 2 3 1;
             1 2 3 3 1;
             0 1 1 1 0];

valeurs     = unique(small_img(:));
frequences  = histc(small_img(:), valeurs);

figure('Name', 'Exercice 5 - Histogramme petite image', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Exercice 5 : Histogramme de l image 5x5', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

subplot(1,2,1);
imagesc(small_img);
colormap(gca, gray);
colorbar;
title('Image 5x5');
axis equal tight;
[rows, cols] = size(small_img);
for r = 1:rows
    for c = 1:cols
        text(c, r, num2str(small_img(r,c)), ...
            'HorizontalAlignment', 'center', ...
            'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');
    end
end

subplot(1,2,2);
bar(valeurs, frequences, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Valeur de pixel');
ylabel('Frequence');
title('Histogramme de la petite image');
xticks(valeurs);
grid on;

fprintf('\n--- Exercice 5 : Histogramme de la petite image ---\n');
fprintf('Valeur | Frequence\n');
fprintf('-------+-----------\n');
for i = 1:length(valeurs)
    fprintf('  %d    |    %d\n', valeurs(i), frequences(i));
end

%% --- Exercice 6 : Histogramme + Egalisation de color-img en gris

figure('Name', 'Exercice 6 - Egalisation histogramme', 'NumberTitle', 'off');
annotation('textbox', [0.3 0.95 0.4 0.05], 'String', 'Exercice 6 : Egalisation de l histogramme', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

subplot(2,3,1);
imshow(gray_img);
title('Image grise originale');

subplot(2,3,2);
imhist(gray_img);
title('Histogramme original');
xlabel('Intensite');
ylabel('Frequence');

gray_eq = histeq(gray_img);

subplot(2,3,3);
imhist(gray_eq);
title('Histogramme egalise');
xlabel('Intensite');
ylabel('Frequence');

subplot(2,3,4);
imshow(gray_img);
title('Avant egalisation');

subplot(2,3,5);
imshow(gray_eq);
title('Apres egalisation');

subplot(2,3,6);
[counts, ~] = imhist(gray_img);
cdf = cumsum(counts) / sum(counts);
plot(0:255, cdf * 255, 'b-', 'LineWidth', 2);
xlabel('Intensite originale');
ylabel('Intensite transformee');
title('Courbe de transformation (CDF)');
grid on;

fprintf('\nScript termine avec succes!\n');