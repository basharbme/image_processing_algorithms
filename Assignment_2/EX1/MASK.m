imgRGB = imread('download.jpeg');   
                                    
img = rgb2gray(imgRGB);
% mask = [1 2 3; 4 5 6; 7 8 9];      % mask can be changed here
mask = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15; 16 17 18 19 20; 21 22 23 24 25];
mask_size = size(mask);

figure
imshow(img)
title("Original image")

%%

img_size = size(img);
new_img = zeros(img_size);
m_diff = floor(mask_size(1)/2);
n_diff = floor(mask_size(2)/2);

img = padarray(img, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
for m = 1+m_diff:img_size(1)+m_diff
   for n = 1+n_diff:img_size(2)+n_diff
       mask_sum = 0;
       for temp_m = m-m_diff:m+m_diff
           for temp_n = n-n_diff:n+n_diff
               mask_sum = mask_sum + double(img(temp_m, temp_n)) * mask(m-temp_m+mask_size(1)-m_diff, n-temp_n+mask_size(2)-n_diff);
           end       
       end
       new_img(m, n) = mask_sum/sum(sum(mask));
   end
end

figure
imshow(uint8(new_img))
title("Image after applying a filter")
