% Task: Independent work
% Image Compression using Discrete Cosine Transform (DCT)

% Load several color and grayscale images of different types from MATLAB's library.
F1 = imread('peppers.png'); % Sample color image

% Convert color images to grayscale and display the result.
I1 = rgb2gray(F1);

% Show original and grayscale images side by side
figure;
subplot(1, 2, 1);
imshow(F1);
title('Original Color Image');

subplot(1, 2, 2);
imshow(I1);
title('Grayscale Image of Peppers');

% Perform Discrete Cosine Transform on the images and display the DCT results.
J1 = dct2(I1);
% Display grayscale image and DCT spectrum side by side
figure;
subplot(1, 2, 1);
imshow(I1);
title('Grayscale Image of Peppers');

subplot(1, 2, 2);
imshow(log(abs(J1)), []);
title('DCT Spectrum of Peppers');
colorbar;

% Reconstruct the image from its DCT spectrum.
K1 = idct2(J1);
% Display DCT spectrum and reconstructed image side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(J1)), []);
title('DCT Spectrum of Peppers');
colorbar;

subplot(1, 2, 2);
imshow(K1, [0 255]);
title('Reconstructed Image');

% Quantize the DCT results using integer division/multiplication for different quantization step sizes.
N = 10; % Quantization step
J1_quantized = N * round(J1 / N);
% Display original DCT and quantized DCT spectrum side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(J1)), []);
title('Original DCT Spectrum');
colorbar;

subplot(1, 2, 2);
imshow(log(abs(J1_quantized)), []);
title('Quantized DCT Spectrum');
colorbar;

% Reconstruct the image from the quantized DCT spectrum.
K1_from_quantized = idct2(J1_quantized);
% Display quantized DCT and reconstructed image side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(J1_quantized)), []);
title('Quantized DCT Spectrum');
colorbar;

subplot(1, 2, 2);
imshow(K1_from_quantized, [0 255]);
title('Reconstructed from Quantized DCT');

% Check if similar results can be achieved by quantizing the original image directly.
I_quantized_directly = N * round(double(I1) / N);
% Display grayscale and directly quantized image side by side
figure;
subplot(1, 2, 1);
imshow(I1);
title('Grayscale Image');

subplot(1, 2, 2);
imshow(I_quantized_directly, [0 255]);
title('Directly Quantized Image');
