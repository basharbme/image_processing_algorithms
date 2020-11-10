function border_img = outer_border(img)
    border_img = 255*ones(size(img, 1), size(img, 2), 'uint8');
    pixel_i = 0;
    pixel_j = 0;
    % Find uppermost-left corner pixel (a.k.a. starting pixel)
    for i=1:size(img,1)
        for j=1:size(img, 2)
            if (img(i,j) == 0)
                % Paint border pixel and set new pixel's coordinates
                border_img(i, j) = 0;
                pixel_i = i;
                pixel_j = j;
                break;
            end
        end
        if (pixel_i == i) %If first pixel is set, break the loop
            break;
        end
    end

    % Go clockwise in each pixels neighbors to draw external borders
    nn_i = -1; % Next Neighbour x-coordinate 
    nn_j = -1; % Next Neighbour y-coordinate
    
    pass_round = 0;
   
    while 1 
        if (img(pixel_i + nn_i, pixel_j + nn_j) == 0) && (border_img(pixel_i + nn_i, pixel_j + nn_j) == 255) && (pass_round == 0)
            % Paint border pixel in border_img
            border_img(pixel_i + nn_i, pixel_j + nn_j) = 0;
            % Selecting new neighbour as main pixel
            pixel_i = pixel_i + nn_i;
            pixel_j = pixel_j + nn_j;
            % Fixing the next neighbors directions to the opposite of
            % current direction
            nn_i = 0 - nn_i;
            nn_j = 0 - nn_j;
            % In order to move nn_i and nn_j to the next neighbour, we need
            % to define a variable to pass this round without checking
            % already painted pixel
            pass_round = 1;  
            continue;
        else %Hardcoded movement of direction through 8 neighbours
            if (nn_i == -1) && (nn_j == -1)
                nn_i = -1;
                nn_j = 0;
            elseif (nn_i == -1) && (nn_j == 0)
                nn_i = -1;
                nn_j = 1;
            elseif (nn_i == -1) && (nn_j == 1)
                nn_i = 0;
                nn_j = 1;
            elseif (nn_i == 0) && (nn_j == 1)
                nn_i = 1;
                nn_j = 1;
            elseif (nn_i == 1) && (nn_j == 1)
                nn_i = 1;
                nn_j = 0;
            elseif (nn_i == 1) && (nn_j == 0)
                nn_i = 1;
                nn_j = -1;
            elseif (nn_i == 1) && (nn_j == -1)
                nn_i = 0;
                nn_j = -1;
            elseif (nn_i == 0) && (nn_j == -1)
                nn_i = -1;
                nn_j = -1;
            end
        end
        
        % If new neighbouring pixel corresponds to already painted pixel,
        % which means that the loop is closing, then break the while loop.
        if (img(pixel_i + nn_i, pixel_j + nn_j) == 0) && (border_img(pixel_i + nn_i, pixel_j + nn_j) == 0)
            break;
        end
        % Reset pass_round variable
        pass_round = 0;
    end
end