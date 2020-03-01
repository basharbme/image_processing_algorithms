% imgRGB = imread('example.png');                          
% img = rgb2gray(imgRGB);
img = imread('building.jpg'); 

sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];
mask_size = size(sobel_x);

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
 
% for m = 1:img_size(1)
%     for n = 1:img_size(2)
%         if new_img_sobel_x(m, n) < 130
%             new_img_sobel_x(m, n) = 0;
%         elseif new_img_sobel_x(m, n) > 130
%             new_img_sobel_x(m, n) = 255;
%         end
%     end
% end

%%
new_img_sobel_y = zeros(img_size);

% img = padarray(img, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
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
% 
% for m = 1:img_size(1)
%     for n = 1:img_size(2)
%         if new_img_sobel_y(m, n) < 130
%             new_img_sobel_y(m, n) = 0;
%         elseif new_img_sobel_y(m, n) > 130
%             new_img_sobel_y(m, n) = 255;
%         end
%     end
% end


%%

edge_img = sqrt(new_img_sobel_x.^2+new_img_sobel_y.^2);

for m = 1:img_size(1)
    for n = 1:img_size(2)
        if edge_img(m, n) <= 120
            edge_img(m, n) = 0;
        elseif edge_img(m, n) > 120
            edge_img(m, n) = 255;
        end
    end
end



figure
subplot(2,2,1);
imshow(img)
title("Original image")

subplot(2,2,2);
imshow(uint8(new_img_sobel_x))
title("Sobel operator - Gx")

subplot(2,2,3);
imshow(uint8(new_img_sobel_y))
title("Sobel operator - Gy")

subplot(2,2,4);
imshow(edge_img)
title("Sobel operator combined")

