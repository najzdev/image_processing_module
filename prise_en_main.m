%% Atelier 1 - Programmation avec MATLAB

clear
clc
close all

%% -----------------------------
% Vector manipulation
%% -----------------------------

u = [2 5 3 8 1];

u_gauche = [u(2:end) u(end)];
u_droite = [u(1) u(1:end-1)];

disp('Vector u:')
disp(u)

disp('Left shift:')
disp(u_gauche)

disp('Right shift:')
disp(u_droite)

%% -----------------------------
% Matrix manipulation
%% -----------------------------

A = zeros(2,3);

A(1,1) = 1;
A(2,:) = [3 5 8];

disp('Matrix A:')
disp(A)

disp('A as column vector:')
disp(A(:))

%% -----------------------------
% Random matrix and element-wise multiplication
%% -----------------------------

B = rand(2,3);

disp('Matrix B:')
disp(B)

C = A .* B;

disp('Element-wise multiplication C = A .* B:')
disp(C)

%% -----------------------------
% Random image and binarization
%% -----------------------------

I = rand(256,256);

figure;
imshow(I);
title('Random Image');

I(I < 0.5) = 0;
I(I >= 0.5) = 1;

figure;
imshow(I);
title('Binary Image');

%% -----------------------------
% Gradient image
%% -----------------------------

V = 0:255;
disp(['Dimensions of V: ' num2str(size(V))])

I = repmat(V,256,1);
disp(['Dimensions of I: ' num2str(size(I))])

figure;
imshow(I);
title('Gradient - Auto Scaling');

figure;
imshow(I,[0 255]);
title('Gradient - Manual Scaling [0 255]');

%% -----------------------------
% Modify image
%% -----------------------------

I(128,:) = 255;

figure;
imshow(I,[0 255]);
title('White Line at Row 128');

I(100:140,:) = 255 * rand(41,256);

figure;
imshow(I,[0 255]);
title('Random Pattern Added');