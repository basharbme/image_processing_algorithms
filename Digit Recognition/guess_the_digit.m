%%% The script is designed to classify the digits according to
%%% their distances_matrix features 

function digit = guess_the_digit(img)
    resized_img = crop_n_resize(img, 40);
    eroded_img = imdilate(resized_img, [0 1 0; 0 1 0; 0 1 0]);
    dist_mx = distance_arrays(eroded_img);
    
    if (0.7<dist_mx(2) && dist_mx(2)<1.3) && ...
        (0.7<dist_mx(4) && dist_mx(4)<1.3)
        if (0.7<dist_mx(5) && dist_mx(5)<1.3) && ...
                (dist_mx(6)<3) && (dist_mx(1)<3)
            digit = '0';
        elseif (dist_mx(5)>3)
            digit = '6';
        elseif (dist_mx(1)>3)
            digit = '7';
        elseif (dist_mx(6)>3)
            digit = '9';
        else 
            digit = 'Not identified*'
        end
    elseif (dist_mx(3)>1.3) && (dist_mx(2) < 0.7) && ...
            (0.7<dist_mx(6) && dist_mx(6)<1.3) && dist_mx(5)<2
        digit = '1';
    elseif (dist_mx(3)>1.3) && (dist_mx(2) < 0.7) && ...
            (dist_mx(5)>2)
        digit = '2';
    elseif (dist_mx(3)>1.3) && (dist_mx(4)>1.3) && ...
            (dist_mx(5)>1.3) && (dist_mx(6)>1.3)
        digit = '3';
    elseif (dist_mx(3)<0.7) && (dist_mx(4)<0.7) && ...
            (dist_mx(6)<0.7)
        digit = '4';
    elseif (dist_mx(2)>1.3) && (dist_mx(3)< 0.7) && ...
            (dist_mx(6)>1.3)
        digit = '5';
    elseif (0.7<dist_mx(2) && dist_mx(2)<1.3) && ...
            (dist_mx(3)>1.3) && (dist_mx(4)>1.3)
        digit = '8';
    else 
        digit = 'Not identified';
    end;
end