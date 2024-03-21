% Завдання 1: Завантаження тестових зображень з бібліотеки MATLAB
I = imread('peppers.png'); % Стандартне тестове зображення

% Завдання 2: Відображення вихідних зображень
figure, imshow(I), title('Original Image');

% Завдання 3: Зашумлення зображення
I_noisy_gauss = imnoise(I, 'gaussian', 0, 0.05); % Додавання гаусівського шуму
I_noisy_sp = imnoise(I, 'salt & pepper', 0.05); % Додавання шуму "сіль і перець"

% Завдання 4: Відображення зашумлених зображень
figure, imshow(I_noisy_gauss), title('Gaussian Noisy Image');
figure, imshow(I_noisy_sp), title('Salt & Pepper Noisy Image');

% Завдання 5 і 7: Фільтрація зашумлених зображень різними фільтрами
% Створення фільтрів
h_average = fspecial('average', [3 3]); % Усереднюючий фільтр
h_gaussian = fspecial('gaussian', [3 3], 0.05); % Гаусівський фільтр
h_unsharp = fspecial('unsharp'); % Фільтр для підсилення гостроти зображення

% Застосування фільтрів до зашумлених зображень
I_gauss_filtered_average = imfilter(I_noisy_gauss, h_average);
I_sp_filtered_average = imfilter(I_noisy_sp, h_average);
I_gauss_filtered_gaussian = imfilter(I_noisy_gauss, h_gaussian);
I_sp_filtered_gaussian = imfilter(I_noisy_sp, h_gaussian);
I_gauss_filtered_unsharp = imfilter(I_noisy_gauss, h_unsharp);
I_sp_filtered_unsharp = imfilter(I_noisy_sp, h_unsharp);

% Відображення результатів фільтрації
figure, imshow(I_gauss_filtered_average), title('Gaussian Noise - Average Filter');
figure, imshow(I_sp_filtered_average), title('Salt & Pepper Noise - Average Filter');
figure, imshow(I_gauss_filtered_gaussian), title('Gaussian Noise - Gaussian Filter');
figure, imshow(I_sp_filtered_gaussian), title('Salt & Pepper Noise - Gaussian Filter');
figure, imshow(I_gauss_filtered_unsharp), title('Gaussian Noise - Unsharp Filter');
figure, imshow(I_sp_filtered_unsharp), title('Salt & Pepper Noise - Unsharp Filter');

% Завдання 8: Адаптивна фільтрація Вінером
% Отримання окремих кольорових каналів зображення
R = I_noisy_gauss(:,:,1);
G = I_noisy_gauss(:,:,2);
B = I_noisy_gauss(:,:,3);

% Застосування фільтра Вінера до кожного кольорового каналу
R_filtered = wiener2(R, [5 5]);
G_filtered = wiener2(G, [5 5]);
B_filtered = wiener2(B, [5 5]);

% Об'єднання фільтрованих каналів назад в одне зображення
I_wiener_gauss = cat(3, R_filtered, G_filtered, B_filtered);
figure, imshow(I_wiener_gauss), title('Gaussian Noise - Wiener Filter');

% Отримання окремих кольорових каналів зашумленого зображення "сіль і перець"
R_sp = I_noisy_sp(:,:,1);
G_sp = I_noisy_sp(:,:,2);
B_sp = I_noisy_sp(:,:,3);

% Застосування фільтра Вінера до кожного кольорового каналу
R_sp_filtered = wiener2(R_sp, [5 5]);
G_sp_filtered = wiener2(G_sp, [5 5]);
B_sp_filtered = wiener2(B_sp, [5 5]);

% Об'єднання фільтрованих каналів назад в одне кольорове зображення
I_wiener_sp = cat(3, R_sp_filtered, G_sp_filtered, B_sp_filtered);
figure, imshow(I_wiener_sp), title('Salt & Pepper Noise - Wiener Filter');

% Завдання 9: Медіанна фільтрація зашумлених зображень
% Медіанна фільтрація для гаусівського шуму (виправлено)
R_gauss = I_noisy_gauss(:,:,1);
G_gauss = I_noisy_gauss(:,:,2);
B_gauss = I_noisy_gauss(:,:,3);

R_gauss_med = medfilt2(R_gauss, [3 3]);
G_gauss_med = medfilt2(G_gauss, [3 3]);
B_gauss_med = medfilt2(B_gauss, [3 3]);

I_median_gauss = cat(3, R_gauss_med, G_gauss_med, B_gauss_med);
figure, imshow(I_median_gauss), title('Gaussian Noise - Median Filter');

% Медіанна фільтрація для шуму "сіль і перець" (виправлено)
R_sp = I_noisy_sp(:,:,1);
G_sp = I_noisy_sp(:,:,2);
B_sp = I_noisy_sp(:,:,3);

R_sp_med = medfilt2(R_sp, [3 3]);
G_sp_med = medfilt2(G_sp, [3 3]);
B_sp_med = medfilt2(B_sp, [3 3]);

I_median_sp = cat(3, R_sp_med, G_sp_med, B_sp_med);
figure, imshow(I_median_sp), title('Salt & Pepper Noise - Median Filter');