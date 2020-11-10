function nn_new_img = interpolation_resize(img, ratio)
    old_size = size(img);
    new_size = floor(old_size*ratio);
    
    nn_new_img = logical(zeros(new_size));
    for m = 1:new_size(1)
       for n = 1:new_size(2)
           old_m = ceil(m/ratio);
           old_n = ceil(n/ratio);
           nn_new_img(m, n) = img(old_m, old_n);
       end
    end
end