%%% Script for getting mean distance relations values and their
%%% standard deviations.


% img = imread('images/4.bmp');

% if png
all_means = [];
all_stds = [];
is_reliable = [];
% figure
for number = 0:9
    distances_matrix = [];
    for i = 1:19
%         image_path = sprintf('testingData/num%sset0size%s.png', int2str(number), int2str(47+i));
        image_path = sprintf('TrainingData/num%sset%s.png', int2str(number), int2str(i));
        imgRGB = imread(image_path);
        img = im2bw(imgRGB, 0.5);
        resized_img = crop_n_resize(img, 40);
        eroded_img = imdilate(resized_img, [0 1 0; 0 1 0; 0 1 0]);
        distances_matrix(i, :) = distance_arrays(eroded_img);
%         subplot(3, 3, i);
%         imshow(resized_img)    

        for col = 1:6
            all_means(number+1, col) = mean(distances_matrix(:, col));            
            std_val = std(distances_matrix(:, col));
            all_stds(number+1, col) = std_val;
            
            if std_val <= 0.5
                is_reliable(number+1, col) = true;
            else
                is_reliable(number+1, col) = false;
            end
        end
    end
end
