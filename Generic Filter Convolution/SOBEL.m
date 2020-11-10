imgRGB = imread('example.png');   
                                    
img = rgb2gray(imgRGB);
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];
mask_size = size(sobel_x);

figure
imshow(img)
title("Original image")

%%

img_size = size(img);
new_img_sobel_x = zeros(img_size);
new_img_sobel_x_abs = zeros(img_size);
m_diff = floor(mask_size(1)/2);
n_diff = floor(mask_size(2)/2);

for m = 1:img_size(1)
   for n = 1:img_size(2)
       mask_sum = 0;
       for temp_m = m-m_diff:m+m_diff
           if (temp_m >= 1) & (temp_m <= img_size(1))
               for temp_n = n-n_diff:n+n_diff
                   if (temp_n >= 1) & (temp_n <= img_size(2))
                       mask_sum = mask_sum + double(img(temp_m, temp_n)) * sobel_x(m-temp_m+mask_size(1)-1, n-temp_n+mask_size(2)-1);
                   end
               end
           end       
       end
       
       new_img_sobel_x(m, n) = mask_sum;
   end
end

for m = 1:img_size(1)
    for n = 1:img_size(2)
        new_img_sobel_x_abs(m, n) = abs(new_img_sobel_x(m, n));
        
        if new_img_sobel_x_abs(m, n) < 50
            new_img_sobel_x_abs(m, n) = 0;
        end
    end
end

for m = 1:img_size(1)
    for n = 1:img_size(2)
        if new_img_sobel_x(m, n) < 50
            new_img_sobel_x(m, n) = 0;
        elseif new_img_sobel_x(m, n) > 50
            new_img_sobel_x(m, n) = 255;
        end
    end
end

figure
% subplot(1,2,1);
imshow(uint8(new_img_sobel_x))
title("Masked image (with negative values zeroed)")

% subplot(1,2,2);
% figure
% imshow(uint8(new_img_sobel_x_abs))
% title("Masked image (with absolute values)")
% 

%%
img_size = size(img);
new_img_sobel_y = zeros(img_size);
m_diff = floor(mask_size(1)/2);
n_diff = floor(mask_size(2)/2);

for m = 1:img_size(1)
   for n = 1:img_size(2)
       mask_sum = 0;
       for temp_m = m-m_diff:m+m_diff
           if (temp_m >= 1) & (temp_m <= img_size(1))
               for temp_n = n-n_diff:n+n_diff
                   if (temp_n >= 1) & (temp_n <= img_size(2))
                       mask_sum = mask_sum + double(img(temp_m, temp_n)) * sobel_y(m-temp_m+mask_size(1)-1, n-temp_n+mask_size(2)-1);
                   end
               end
           end       
       end
       
       new_img_sobel_y(m, n) = mask_sum;
   end
end

% for m = 1:img_size(1)
%     for n = 1:img_size(2)
%         new_img_sobel_y(m, n) = abs(new_img_sobel_y(m, n));
%         
%         if new_img_sobel_y(m, n) < 80
%             new_img_sobel_y(m, n) = 0;
%         end
%     end
% end


for m = 1:img_size(1)
    for n = 1:img_size(2)
        if new_img_sobel_y(m, n) < 100
            new_img_sobel_y(m, n) = 0;
        elseif new_img_sobel_y(m, n) > 100
            new_img_sobel_y(m, n) = 255;
        end
    end
end

figure
imshow(uint8(new_img_sobel_y))
title("Image after applying a filter")
%%
edge_img = sqrt(new_img_sobel_x.^2+new_img_sobel_y.^2);
figure
imshow(uint8(edge_img))

%%
