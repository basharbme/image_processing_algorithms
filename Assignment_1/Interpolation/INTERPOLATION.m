% imgRGB = imread('download.jpeg'); % bigger original image

imgRGB = imread('download1.jpg');   % here size of image is reduced even 
                                    % more to see clearer results
img = rgb2gray(imgRGB);
ratio = 5;                          % ratio can be changed here

figure
subplot(2,3,[1,2,3]);
imshow(img)
title("Original image")

%%
% Nearest-Neighbor Interpolation
old_size = size(img);

new_size = floor(old_size*ratio);
nn_new_img = uint8(zeros(new_size));

for m = 1:new_size(1)
   for n = 1:new_size(2)
       old_m = ceil(m/ratio);
       old_n = ceil(n/ratio);
       nn_new_img(m, n) = img(old_m, old_n);
   end
end

subplot(2,3,4);
imshow(uint8(nn_new_img))
title("Nearest-Neighbor Interpolation")

%%

% Bilinear Interpolation
bilinear_new_img = zeros(new_size);
pix_weights = [5, 2]; % weights of main pixel and its neighbors

for m = 1:new_size(1)
   for n = 1:new_size(2)
       old_m = ceil(m/ratio);
       old_n = ceil(n/ratio);
       pixel_sum = pix_weights(1)*double(img(old_m, old_n));
       pixel_count = pix_weights(1);
       
       if (old_m < old_size(1))
           pixel_sum = pixel_sum + pix_weights(2)*double(img(old_m + 1, old_n));
           pixel_count = pixel_count + pix_weights(2);
       end
       
       if (old_m > 1)
           pixel_sum = pixel_sum + pix_weights(2)*double(img(old_m - 1, old_n));
           pixel_count = pixel_count + pix_weights(2);
       end
       
       if(old_n < old_size(2))
           pixel_sum = pixel_sum + pix_weights(2)*double(img(old_m, old_n + 1));
           pixel_count = pixel_count + pix_weights(2);
       end
       
       if (old_n > 1)
           pixel_sum = pixel_sum + pix_weights(2)*double(img(old_m, old_n - 1));
           pixel_count = pixel_count + pix_weights(2);
       end
       
       bilinear_new_img(m, n) = pixel_sum/pixel_count;
   end
end

subplot(2,3,5);
imshow(uint8(bilinear_new_img))
title("Bilinear Interpolation")

%%
% Bicubic Interpolation

bicubic_new_img = zeros(new_size);
normal_dist = [11, 4, 1]; % weights of original pixel and next two layers

for m = 1:new_size(1)
   for n = 1:new_size(2)
       old_m = ceil(m/ratio);
       old_n = ceil(n/ratio);
       column_sum = normal_dist(1)*double(img(old_m, old_n));
       column_count = normal_dist(1);
       
       for temp_m = old_m-2:old_m+2
           if (temp_m >= 1) & (temp_m <= old_size(1))
               row_sum = 0;
               row_count = 0;
               for temp_n = old_n-2:old_n+2
                   if (temp_n >= 1) & (temp_n <= old_size(2))
                       elem_weight = normal_dist(abs(old_n - temp_n) + 1);
                       row_sum = row_sum + elem_weight * double(img(temp_m, temp_n));
                       row_count = row_count + elem_weight;
                   end
               end
               row_weight = normal_dist(abs(old_m - temp_m) + 1);
               column_sum = column_sum + row_weight*(row_sum / row_count);
               column_count = column_count + row_weight;
           end       
       end
       
       bicubic_new_img(m, n) = column_sum/column_count;
   end
end

subplot(2,3,6);
imshow(uint8(bicubic_new_img))
title("Bicubic Interpolation")

%%
% If seeing original (without MATLAB zooming) sizes of original
% and interpolated images is desired, please uncomment following lines:

% figure
% subplot(1,1,1);
% imshow(img)
% title("Original image")
% 
% figure
% subplot(1,1,1);
% imshow(uint8(nn_new_img))
% title("Nearest-Neighbor Interpolation")
% 
% figure
% subplot(1,1,1);
% imshow(uint8(bicubic_new_img))
% title("Bilinear Interpolation")
% 
% figure
% subplot(1,1,1);
% imshow(uint8(bilinear_new_img))
% title("Bicubic Interpolation")

