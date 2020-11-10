function resized_img = crop_n_resize(img, width)
    leftmost = size(img, 2);
    rightmost = 1;
    topmost = size(img,1);
    bottommost = 1;
    for i=1:size(img,1)
        for j=1:size(img, 2)
            if (img(i,j) == 0)
                if (j <= leftmost && j >= 1)
                    leftmost = j;
                end

                if (j >= rightmost && j <= size(img, 2))
                   rightmost = j; 
                end

                if (i <= topmost && i >= 1)
                    topmost = i;
                end

                if (i >= bottommost && i <= size(img,1))
                    bottommost = i;
                end
            end
        end
    end
    
    desired_img_width = width;
    img = padarray(img, [1 1]);
    cropped_img = img(topmost-1:bottommost+1, leftmost-1:rightmost+1 );
    cropped_img_size = size(cropped_img);
    resized_img = interpolation_resize(cropped_img, desired_img_width/cropped_img_size(2));
end