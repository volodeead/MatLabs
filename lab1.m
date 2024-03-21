% Завдання 1: Завантаження та відображення зображень у різних форматах
image1 = imread('D:/Programing/Cursova/project/source/DJI_0749.JPG'); 
image2 = imread('D:/Programing/Cursova/output/temp/0_20230515_114629.png'); 
figure, imshow(image1), title('Image 1');
figure, imshow(image2), title('Image 2');

% Завдання 2: Завантаження зображення з довільного каталогу вже виконано в завданні 1

% Завдання 3: Отримання інформації про завантажені зображення
info1 = imfinfo('D:/Programing/Cursova/project/source/DJI_0749.JPG');
info2 = imfinfo('D:/Programing/Cursova/output/temp/0_20230515_114629.png');
disp(info1); % Відображення інформації про перше зображення
disp(info2); % Відображення інформації про друге зображення

% Завдання 4: Збереження завантажених зображень в заданому каталозі
imwrite(image1, 'D:/University2024/MatLabs/DJI_0749.JPG'); 
imwrite(image2, 'D:/University2024/MatLabs/0_20230515_114629.png'); 

% Завдання 5: Гістограми розподілу яскравостей
figure, imhist(image1), title('Histogram of Image 1');
figure, imhist(image2), title('Histogram of Image 2');

% Завдання 6 і 7: Контрастування зображень і відображення з підвищеною контрастністю
% Розділення зображення на кольорові канали
image1_R = image1(:,:,1);
image2_G = image1(:,:,2);
image2_B = image1(:,:,3);

% Коригування контрасту для кожного кольорового каналу
adjusted1_R = imadjust(image1_R);
adjusted1_G = imadjust(image2_G);
adjusted1_B = imadjust(image2_B);

% Збирання каналів назад в одне зображення
image1_adjusted = cat(3, adjusted1_R, adjusted1_G, adjusted1_B);

% Відображення зображення з підвищеною контрастністю
figure, imshow(image1_adjusted), title('Adjusted Image 1');

% Розділення зображення на кольорові канали
image2_R = image2(:,:,1);
image2_G = image2(:,:,2);
image2_B = image2(:,:,3);

% Коригування контрасту для кожного кольорового каналу
adjusted2_R = imadjust(image2_R);
adjusted2_G = imadjust(image2_G);
adjusted2_B = imadjust(image2_B);

% Збирання каналів назад в одне зображення
image2_adjusted = cat(3, adjusted2_R, adjusted2_G, adjusted2_B);

% Відображення зображення з підвищеною контрастністю
figure, imshow(image2_adjusted), title('Adjusted Image 2');

% Завдання 8: Негатив зображення
image1_negative = imcomplement(image1);
image2_negative = imcomplement(image2);
figure, imshow(image1_negative), title('Negative Image 1');
figure, imshow(image2_negative), title('Negative Image 2');