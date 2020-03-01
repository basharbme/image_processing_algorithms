imgRGB = imread('example.png');  
img = rgb2gray(imgRGB);

% img = imread('building.jpg'); 
                                   
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];
mask_size = size(sobel_x);

figure
imshow(img)
title("Original image")

%%

img_size = size(img);
new_img_sobel_x = zeros(img_size);
m_diff = floor(mask_size(1)/2);
n_diff = floor(mask_size(2)/2);

img_pad = padarray(img, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
for m = 1+m_diff:img_size(1)+m_diff
   for n = 1+n_diff:img_size(2)+n_diff
       mask_sum = 0;
       for temp_m = m-m_diff:m+m_diff
           for temp_n = n-n_diff:n+n_diff
               mask_sum = mask_sum + double(img_pad(temp_m, temp_n)) * sobel_x(m-temp_m+mask_size(1)-m_diff, n-temp_n+mask_size(2)-n_diff);
           end       
       end
       new_img_sobel_x(m, n) = mask_sum;
   end
end

%%
new_img_sobel_y = zeros(img_size);

for m = 1+m_diff:img_size(1)+m_diff
   for n = 1+n_diff:img_size(2)+n_diff
       mask_sum = 0;
       for temp_m = m-m_diff:m+m_diff
           for temp_n = n-n_diff:n+n_diff
               mask_sum = mask_sum + double(img_pad(temp_m, temp_n)) * sobel_y(m-temp_m+mask_size(1)-m_diff, n-temp_n+mask_size(2)-n_diff);
           end       
       end
       new_img_sobel_y(m, n) = mask_sum;
   end
end

%%

threshhold = 150; % Can be changed here
edge_img = sqrt(new_img_sobel_x.^2+new_img_sobel_y.^2);
edge_img_size = size(edge_img);

for m = 1:edge_img_size(1)
    for n = 1:edge_img_size(2)
        if edge_img(m, n) <= threshhold
            edge_img(m, n) = 0;
        elseif edge_img(m, n) > threshhold
            edge_img(m, n) = 255;
        end
    end
end

figure
subplot(1,3,1)
imshow(uint8(new_img_sobel_x))
title("Sobel operator - Gx")
subplot(1,3,2)
imshow(uint8(new_img_sobel_y))
title("Sobel operator - Gy")
subplot(1,3,3)
imshow(uint8(edge_img))
title("Sobel operator combined")

%% HOUGH TRANSFORM

y = [];
x = [];
theta = [-pi/2:0.01:pi/2];
theta_size = size(theta);
rho_offset = ceil(sqrt(img_size(1)^2 + img_size(2)^2));
hough_space = zeros(2*rho_offset, theta_size(2));

% Finding non zero values in edge image
for m = 1:edge_img_size(1) 
    for n = 1:edge_img_size(2)
        if (edge_img(m, n) == 255)
            y = [y; m];
            x = [x; n];
        end
    end
end
y = y - 1;
x = x - 1;

x_size = size(x);
rho = zeros(x_size(1), theta_size(2));
cos_thetas = cos(theta);
sin_thetas = sin(theta); % saves computation time
for i = 1:x_size(1)
    rho(i, :) = x(i).*cos_thetas + y(i).*sin_thetas;
    rho(i, :) = floor(rho(i,:) + rho_offset) + 1;
    for j = 1:theta_size(2)
        hough_space(rho(i, j), j) = hough_space(rho(i, j), j) + 1; 
    end
end

%%
% hough_space = zeros(800, 1500);
% 
% y = [];
% x = [];
% for m = 1:edge_img_size(1)
%     for n = 1:edge_img_size(2)
%         if (edge_img(m, n) == 255)
%             x = [x; m];
%             y = [y; n];
%         end
%     end
% end
% 
% x_size = size(x);
% 
% thetas = [];
% rhos = [];
% for i = 1:x_size(1)
%     theta = atan2(new_img_sobel_y(x(i), y(i)), new_img_sobel_x(x(i), y(i)));
%     thetas = [thetas, theta];
%     rho = x(i)*cos(theta) + y(i)*sin(theta);
%     rhos = [rhos, rho];
% %     hough_space(ceil(theta+4.1398)*100, ceil(rho+673)) = hough_space(ceil(theta+4.1398)*100, ceil(rho+673)) + 1;
% end
% 
% % imshow(hough_space)

%% HOUGH TRANSFORM USING GRADIENTS

thetas = zeros(edge_img_size(1), edge_img_size(2));
amps = zeros(edge_img_size(1), edge_img_size(2));

for m = 1:edge_img_size(1)
    for n = 1:edge_img_size(2)
        thetas(m, n) = atan2(new_img_sobel_y(m, n), new_img_sobel_x(m, n));
        amps(m, n) = sqrt(new_img_sobel_y(m, n)^2 + new_img_sobel_x(m, n)^2);
    end
end

rho_offset = ceil(sqrt(img_size(1)^2 + img_size(2)^2));
hough_space_grad = zeros(2*rho_offset, 361);
for i=1:img_size(1)
    for j=1:img_size(2)
        theta = thetas(i, j);
        rho = i*cos(theta) + j*sin(theta);

        new_rho = round(rho)+rho_offset;
        new_theta = floor((theta + pi) / pi * 180) + 1;
        hough_space_grad(new_rho, new_theta) = hough_space_grad(new_rho, new_theta) + amps(i, j);
    end
end

% imshow(hough_space_grad)

%% COMPARISON

[H,T,R] = hough(edge_img); % Matlab intetrnal Hough transform

figure
subplot(1,3,1)
imshow(hough_space)
title("Obtained Hough Transfrom")

subplot(1,3,2)
imshow(H)
title("MATLAB Hough Transfrom")

subplot(1,3,3)
imshow(hough_space_grad)
title("Obtained Hough Transfrom from gradients")
