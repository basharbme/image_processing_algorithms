function dist_arr = distance_arrays(img)
    dist_arr = [];
    hdist_arr = [];
    vdist_arr = [];
    first_line = 0;
    % Collecting horizontal distances
    for i=1:size(img, 1)
        first_pixel = 0;
        last_pixel = 0;
        for j=1:size(img, 2)
            if (img(i, j) == 0)
                if (first_pixel == 0)
                    first_pixel = j;
                end
                last_pixel = j;
                %for testing
                if (first_line == 0)
                    first_line = i;
                end
            end
        end
        if(first_pixel > 0) && (last_pixel > first_pixel)
            hdist_arr(end+1) = last_pixel - first_pixel;
        end
    end
    
    % Collecting vertical distances
    for j=1:size(img, 2)
        first_pixel = 0;
        last_pixel = 0;
        for i=1:size(img, 1)
            if (img(i, j) == 0)
                if (first_pixel == 0)
                    first_pixel = i;
                end
                last_pixel = i;
            end
        end
        if(first_pixel > 0)
            vdist_arr(end+1) = last_pixel - first_pixel;
        end
    end
    
    %Averages
%     dist_arr(1) = mean(hdist_arr);
%     dist_arr(2) = mean(vdist_arr);

    %Distance over average distance (So, relative average)
%     dist_arr(1, :) = hdist_arr/mean(hdist_arr);
%     dist_arr(2, :) = vdist_arr/mean(vdist_arr);
    
    %Only relations of 5 selected distances
    height = max(vdist_arr);
    gap = size(hdist_arr, 2)/4;
   
    first = 2;
    second = round(gap) - 4;
    third = round(2*gap) - 3;
    fourth = round(3*gap) + 2;
    fifth = size(hdist_arr, 2) - 3;
    extra_upper = round(gap) + 4;
    extra_lower = round(3*gap) - 5;

    %Relations of consequetive distances
%     dist_arr(1) = hdist_arr(first) / hdist_arr(fifth);
%     dist_arr(2) = hdist_arr(second) / hdist_arr(first);
%     dist_arr(3) = hdist_arr(third) / hdist_arr(second);
%     dist_arr(4) = hdist_arr(fourth) / hdist_arr(third);
%     dist_arr(5) = hdist_arr(fifth) / hdist_arr(fourth);
    
    %Relations of predetermined distances (for symmetry, etc.)
    dist_arr(1) = hdist_arr(first) / hdist_arr(fifth);
    dist_arr(2) = hdist_arr(fourth) / hdist_arr(second);
    dist_arr(3) = hdist_arr(second) / hdist_arr(third);
    dist_arr(4) = hdist_arr(fourth) / hdist_arr(third);
    dist_arr(5) = hdist_arr(second) / hdist_arr(extra_upper);
    dist_arr(6) = hdist_arr(fourth) / hdist_arr(extra_lower);
    
    
    %For testing lines on digits
%     test_img = img;
%     test_img(first_line + first, :) = 0;
%     test_img(first_line + second, :) = 0;
%     test_img(first_line + third, :) = 0;
%     test_img(first_line + fourth, :) = 0;
%     test_img(first_line + fifth, :) = 0;
%     test_img(first_line + extra_upper, :) = 0;
%     test_img(first_line + extra_lower, :) = 0;
    

    
    
    
    
end