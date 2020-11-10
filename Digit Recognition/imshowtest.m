%testing site
for number=1:9
    %number = 3;
    i = 4; 
%     image_path = sprintf('testingData/num%sset0size%s.png', int2str(number), int2str(47+i));
    image_path = sprintf('TrainingData/num%sset%s.png', int2str(number), int2str(i));
    imgRGB = imread(image_path);
    img = im2bw(imgRGB, 0.5);
    resized_img = crop_n_resize(img, 40);
    eroded_img = imdilate(resized_img, [0 1 0; 0 1 0; 0 1 0]);
    distances_matrix = distance_arrays(eroded_img);
%     subplot(3, 3, number);
%     imshow(distances_matrix);
end

