clear all;
close all;
clc;

img = imread('lena.jpg');
img = im2double(img);

% 初始化三个分量
[rows, cols, ~] = size(img);
H = zeros(rows, cols);
S = zeros(rows, cols);
I = zeros(rows, cols);

% S_SC算法计算H、S、I分量
for i = 1:rows
    for j = 1:cols
        R = img(i, j, 1);
        G = img(i, j, 2);
        B = img(i, j, 3);
        % 获取当前像素点最小的颜色通道
        min_val = min([R, G, B]);
        % 获取当前像素点各通道值之和，为下面的计算做准备
        sum_val = R + G + B;

        if min_val == R
            Hflag = '00';
        elseif min_val == G
            Hflag = '01';
        else
            Hflag = '10';
        end

        switch Hflag
            case '00'
                H(i, j) = (2*G - B - R) / (G + B - 2*R);
                S(i, j) = (G + B - 2*R) / sum_val;
            case '01'
                H(i, j) = (2*B - G - R) / (R + B - 2*G);
                S(i, j) = (R + B - 2*G) / sum_val;
            case '10'
                H(i, j) = (2*R - B - G) / (G + R - 2*B);
                S(i, j) = (G + R - 2*B) / sum_val;
        end

        I(i, j) = (1356/4096) * sum_val;
    end
end

figure;
subplot(2, 2, 1);
imshow(H);
title('H');

subplot(2, 2, 2);
imshow(S);
title('S');

subplot(2, 2, 3);
imshow(I);
title('I');

subplot(2, 2, 4);
hsi_image = cat(3, H, S, I);
imshow(hsi_image);
title('HSI');
