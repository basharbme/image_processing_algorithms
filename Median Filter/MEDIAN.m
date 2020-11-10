% commented out sections are only for grayscale

video = VideoReader("noisy.mp4");
% video_out = VideoWriter("filtered");
video_out_RGB = VideoWriter("filtered_RGB_3x3");
% open(video_out)
open(video_out_RGB)
mask_size = [5 5];

for i = 1:1
    frameRGB = read(video, i);
    
%     frame = rgb2gray(frameRGB);
    frameR = frameRGB(:,:,1);
    frameG = frameRGB(:,:,2);
    frameB = frameRGB(:,:,3);
    
    frame_size = size(frameR);
    
%     frame = padarray(frame, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
    frameR = padarray(frameR, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
    frameG = padarray(frameG, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
    frameB = padarray(frameB, [floor(mask_size(1)/2) floor(mask_size(2)/2)]);
    
    
%     frame_out = zeros(frame_size);
    frame_outR = zeros(frame_size);
    frame_outG = zeros(frame_size);
    frame_outB = zeros(frame_size);
    
    m_diff = floor(mask_size(1)/2);
    n_diff = floor(mask_size(2)/2);
    
    for m = (1+m_diff):frame_size(1)+m_diff
       for n = (1+n_diff):frame_size(2)+n_diff
%            values = zeros(1, mask_size(1)*mask_size(2));
           valuesR = zeros(1, mask_size(1)*mask_size(2));
           valuesG = zeros(1, mask_size(1)*mask_size(2));
           valuesB = zeros(1, mask_size(1)*mask_size(2));
           counter = 1;
           for temp_m = m-m_diff:m+m_diff
              for temp_n = n-n_diff:n+n_diff
%                  values(counter) = frame(temp_m, temp_n);
                 valuesR(counter) = frameR(temp_m, temp_n);
                 valuesG(counter) = frameG(temp_m, temp_n);
                 valuesB(counter) = frameB(temp_m, temp_n);
                 counter = counter + 1;
              end
           end
%            sorted = sort(values);
           sortedR = sort(valuesR);
           sortedG = sort(valuesG);
           sortedB = sort(valuesB);
           
%            frame_out(m, n) = sorted(ceil(mask_size(1)*mask_size(2)/2));
           
           frame_outR(m, n) = sortedR(ceil(mask_size(1)*mask_size(2)/2));
           frame_outG(m, n) = sortedG(ceil(mask_size(1)*mask_size(2)/2));
           frame_outB(m, n) = sortedB(ceil(mask_size(1)*mask_size(2)/2)); 
       end
    end
    combinedRGB = cat(3, frame_outR, frame_outG, frame_outB);
    writeVideo(video_out_RGB, uint8(combinedRGB))
    
%     writeVideo(video_out, uint8(frame_out))
end


close(video_out_RGB)

    figure
    imshow(uint8(combinedRGB))
    title("5x5 median filter on R, G, and B layers")