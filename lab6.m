% Lab Work #6 - Block Processing and Implementation of JPEG-like Algorithm

% 1. Load several color and grayscale images of different characters.
F1 = imread('peppers.png'); % Sample color image
F2 = imread('cameraman.tif'); % Sample grayscale image

% 2. Convert color images to grayscale and display the result.
I1 = rgb2gray(F1);
I1 = im2double(I1); % Convert to double precision for DCT calculations

% Show original and grayscale images side by side
figure;
subplot(1, 2, 1);
imshow(F1);
title('Original Color Image');

subplot(1, 2, 2);
imshow(I1);
title('Grayscale Image of Peppers');

% Prepare DCT matrix and block processing functions
N = 8; % Block size
T = dctmtx(N);
dct = @(block_struct) T * block_struct.data * T';
invdct = @(block_struct) T' * block_struct.data * T;

% 3. Perform block DCT on the images
B = blockproc(I1,[N N],dct);

% 4. Display the block DCT result of the entire image using logarithmic scale
figure;
subplot(1, 2, 1);
imshow(I1);
title('Grayscale Image');

subplot(1, 2, 2);
imshow(log(abs(B)), []);
title('Block DCT Spectrum');
colorbar;

% 5. Reconstruct the image from its block DCT spectrum
I2 = blockproc(B,[N N],invdct);

% Show DCT spectrum and reconstructed image side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(B)), []);
title('Block DCT Spectrum');
colorbar;

subplot(1, 2, 2);
imshow(I2);
title('Reconstructed Image');

% 6. Quantize the DCT results using integer division/multiplication for different quantization steps
quantization_step = 10;
B_quantized = quantization_step * round(B / quantization_step);

% Show original DCT and quantized DCT spectrum side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(B)), []);
title('Original DCT Spectrum');
colorbar;

subplot(1, 2, 2);
imshow(log(abs(B_quantized)), []);
title('Quantized DCT Spectrum');
colorbar;

% 7. Reconstruct the image from the quantized DCT spectrum
I3 = blockproc(B_quantized,[N N],invdct);

% Show quantized DCT and reconstructed image side by side
figure;
subplot(1, 2, 1);
imshow(log(abs(B_quantized)), []);
title('Quantized DCT Spectrum');
colorbar;

subplot(1, 2, 2);
imshow(I3);
title('Reconstructed from Quantized DCT');

% Explanation of obtained results and the purpose of quantizing DCT coefficients
% To be written in the report or provided in text format as an explanation.
