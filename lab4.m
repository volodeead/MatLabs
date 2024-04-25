% Завдання 1 - Завантажте з бібліотеки MATLAB кілька різних зображень.
f1 = imread('cameraman.tif');
f2_original = imread('peppers.png');

% Переконуємося, що f2 є у відтінках сірого для правильної обробки FFT
f2 = rgb2gray(f2_original);

% Завдання 2-3  Сформуйте й відобразіть двовимірні спектри зображень.
% Застосування двовимірного перетворення Фур'є
F1 = fft2(f1);
F2 = fft2(f2);

% Центрування спектру
F1_centered = fftshift(F1);
F2_centered = fftshift(F2);

% Відображення спектра з використанням логарифмічного масштабу
F1_log = log(1 + abs(F1_centered));
F2_log = log(1 + abs(F2_centered));

% Нормалізація спектра до максимального значення 255
F1_log_normalized = uint8(255 * mat2gray(F1_log));
F2_log_normalized = uint8(255 * mat2gray(F2_log));

% Відображення спектрів
figure;
subplot(1,2,1);
imshow(F1_log_normalized, []);
title('Cameraman FFT2 Spectrum');

subplot(1,2,2);
imshow(F2_log_normalized, []);
title('Peppers FFT2 Spectrum');

% Завдання 4 - Відновлення зображення за його спектром

% Відновлення зображень із нульовою частотою у верхньому лівому куті (нецентровані спектри)
f1_recovered_noncentered = ifft2(F1);
f2_recovered_noncentered = ifft2(F2);

% Відновлення зображень із нульовою частотою у центрі вікна (центровані спектри)
f1_recovered_centered = ifft2(F1_centered);
f2_recovered_centered = ifft2(F2_centered);

% Відображення оригінальних і відновлених зображень
figure;
subplot(2,4,1);
imshow(f1);
title('Original Cameraman');

subplot(2,4,2);
imshow(log(1 + abs(F1)), []);
title('FFT2 of Cameraman');

subplot(2,4,3);
imshow(abs(f1_recovered_noncentered), []);
title('Recovered (non-centered FFT)');

subplot(2,4,4);
imshow(abs(f1_recovered_centered), []);
title('Recovered (centered FFT)');

subplot(2,4,5);
imshow(f2);
title('Original Peppers');

subplot(2,4,6);
imshow(log(1 + abs(F2)), []);
title('FFT2 of Peppers');

subplot(2,4,7);
imshow(abs(f2_recovered_noncentered), []);
title('Recovered (non-centered FFT)');

subplot(2,4,8);
imshow(abs(f2_recovered_centered), []);
title('Recovered (centered FFT)');


% Завдання 5 - Створення і відображення гаусівського фільтра

% Параметри фільтра
M = 10; % Висота вікна фільтра
N = 10; % Ширина вікна фільтра
sigma = 2; % Стандартне відхилення гаусівського фільтра

% Створення гаусівського фільтра
H = fspecial('gaussian', [M N], sigma);

% Відображення фільтра у вигляді зображення
figure;
imagesc(H);
axis image; % Встановлення рівних масштабів по обом осям для правильного відображення фільтра
colormap('jet'); % Використання кольорової карти для відображення значень
colorbar; % Додавання індикатора для інтерпретації кольорів
title('2D Gaussian Filter');


% Завдання 6 - Визначення та відображення АЧХ гаусівського фільтра

% Змінення розміру вікна фільтра перед виконанням fft2
% Зазвичай використовують розміри, які відповідають розмірам зображення

% Розміри вихідного зображення
image_size = size(f1); % Використовуємо розмір першого зображення як приклад

% Створення великого гаусівського фільтра з тими самими параметрами sigma
large_H = fspecial('gaussian', image_size, sigma);

% Визначення частотної характеристики для великого фільтра
large_H_freq = fft2(large_H);
large_H_freq_shifted = fftshift(large_H_freq);

% Відображення великого АЧХ
figure;
imshow(log(1 + abs(large_H_freq_shifted)), []);
title('Frequency Response of Large 2D Gaussian Filter');


% Завдання 7 - Змінення параметра sigma фільтра, відображення вікна фільтра та його АЧХ

% Визначення розміру вікна фільтра
M = 256;
N = 256;

% Параметри для гаусівських фільтрів
sigma1 = 2;
sigma2 = 5;

% Створення гаусівських фільтрів
H1 = fspecial('gaussian', [M N], sigma1);
H2 = fspecial('gaussian', [M N], sigma2);

% Розміри для АЧХ, щоб відповідати розміру зображення
image_size = [256, 256]; % Приклад розміру зображення

% Створення АЧХ для гаусівських фільтрів з великим розміром
H1_large = fspecial('gaussian', image_size, sigma1);
H2_large = fspecial('gaussian', image_size, sigma2);

% Перетворення Фур'є для отримання АЧХ
H1_freq = fftshift(fft2(H1_large));
H2_freq = fftshift(fft2(H2_large));

% Відображення фільтрів та їхніх АЧХ
figure;

% Гаусівський фільтр з sigma1
subplot(2,4,1);
imagesc(H1);
axis image;
title(['Spatial Filter (sigma=' num2str(sigma1) ')']);

subplot(2,4,2);
imshow(log(1 + abs(H1_freq)), []);
title(['Frequency Response (sigma=' num2str(sigma1) ')']);

% Гаусівський фільтр з sigma2
subplot(2,4,3);
imagesc(H2);
axis image;
title(['Spatial Filter (sigma=' num2str(sigma2) ')']);

subplot(2,4,4);
imshow(log(1 + abs(H2_freq)), []);
title(['Frequency Response (sigma=' num2str(sigma2) ')']);

% Завдання 8 - Фільтрація зображень у частотній області
f = imread('cameraman.tif');
F = fft2(f); 
S=abs(F);
Fc= fftshift(S);
Slog=log(1+Fc);
sigma=3;
h = fspecial('gaussian', [256 256], sigma);
H = fft2(h); 
SH=abs(H);
Shc= fftshift(SH);
Shlog=log(1+Shc);
IF=F.*H;
SIF=abs(IF);
Sifc= fftshift(SIF); 
Sifclog=log(1+Sifc); 
FI = ifft2(IF); 
Fiabs=abs(FI);
Fiabsc= fftshift(Fiabs);
Filog=log(1+Fiabsc);
figure
imshow(Filog, []);
title('Зображення на виході фільтра');
