% Comment out desired image

img = imread('facebook.png');
% img = imread('rectangle.png');

meanIntensity = mean(img(:));
img = img > meanIntensity;

figure
subplot(2,2,1);
imshow(img)
title("Original image")

%%
% Distance Transform

img_size = size(img);
new_img = zeros(img_size);
foreground_counter = 0;
 
% Finding corners 

for m = 1:img_size(1)
    for n = 1:img_size(2)
        if (double(img(m, n)) ~= 1)
            foreground_counter = foreground_counter + 1;
            for temp_m = m-1:m+1
                if (temp_m >= 1) & (temp_m <= img_size(1))
                    for temp_n = n-1:n+1
                        if (temp_n >= 1) & (temp_n <= img_size(2))
                            if (double(img(temp_m, temp_n)) == 1) 
                                new_img(m, n) = 1; 
                            end
                        end
                    end
                end
            end
        end
    end
end

dist_val = 1;
in_process = 1;
while in_process
    int_counter = 0;
    for m = 1:img_size(1)
        for n = 1:img_size(2)
            if (double(new_img(m, n)) ~= 0)
                int_counter = int_counter + 1;
            end
            
            if (foreground_counter == int_counter)
                in_process = 0;
            end 
            
            if (double(img(m, n)) ~= dist_val) & (double(new_img(m, n)) == 0) % 2
                for temp_m = m-1:m+1
                    if (temp_m >= 1) & (temp_m <= img_size(1))
                        for temp_n = n-1:n+1
                            if (temp_n >= 1) & (temp_n <= img_size(2))
                                if (double(new_img(temp_m, temp_n)) == dist_val) % 2                                   
                                    new_img(m, n) = dist_val + 1; % 3
                                end
                            end
                        end
                    end
                end             
            end
        end
    end
    dist_val = dist_val + 1;
end

% Unnormalized distance transform

subplot(2,2,2)
imshow(uint8(new_img))
title("Unnormalized distance transform")

% Normalize new image

for m = 1:img_size(1)
    for n = 1:img_size(2)
        new_img(m, n) = floor(new_img(m, n)*255/dist_val);
    end
end

subplot(2,2,3);
imshow(uint8(new_img))
title("Distance transform")

%%

% Exercise 3 - Skeletonization

scaled_one = floor(1*255/dist_val);
skeleton_img = img;

for m = 1:img_size(1)
    for n = 1:img_size(2)
        if (double(new_img(m, n)) == scaled_one)
            is_corner = 0; 
            if (n > 1) & (m > 1) & (double(new_img(m, n - 1)) == 0) & (double(new_img(m - 1, n)) == 0)
                is_corner = 1;
            elseif (n < img_size(2)) & (m > 1) & (double(new_img(m, n + 1)) == 0) & (double(new_img(m - 1, n)) == 0)
                is_corner = 1;
            elseif (n > 1) & (m < img_size(1)) & (double(new_img(m, n - 1)) == 0) & (double(new_img(m + 1, n)) == 0)
                is_corner = 1;
            elseif (n < img_size(2)) & (m < img_size(1)) & (double(new_img(m, n + 1)) == 0) & (double(new_img(m + 1, n)) == 0)
                is_corner = 1;
            end
            
            if is_corner
                skeleton_img(m, n) = 255;  
                corner_not_finished = 1;
                ptr_m = m;
                ptr_n = n;
                while corner_not_finished             
                    max_val = double(new_img(m, n));
                    termination_counter = 0;
                    max_m = m;
                    max_n = n;

                    for temp_m = ptr_m-1:ptr_m+1
                        if (temp_m >= 1) && (temp_m <= img_size(1))
                            for temp_n = ptr_n-1:ptr_n+1
                                if (temp_n >= 1) && (temp_n <= img_size(2)) 
                                    if double(new_img(temp_m, temp_n)) >= max_val
                                        max_val = double(new_img(temp_m, temp_n));
                                        max_m = temp_m;
                                        max_n = temp_n;
                                    end
                                end
                            end
                        end
                    end
                    skeleton_img(max_m, max_n) = 255;
                    
                    if(ptr_m == max_m && ptr_n == max_n)
                        break
                    end
                    
                    ptr_m = max_m;
                    ptr_n = max_n;

                end     
             end
        end    
    end
end

mi = mean(skeleton_img(:));
skeleton_img = skeleton_img > mi;

subplot(2,2,4);
imshow(skeleton_img)
title("Skeletonization")
