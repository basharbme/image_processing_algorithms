%% Sample image testing
%%% The following script runs the digit prediction pipeline 
%%% through your given sample image.

%%
% If your input file is of bmp format use this section

% Change the path to your selected file
image_path = 'sample image set/0.bmp';
img = imread(image_path);
digit = guess_the_digit(img)

%% 
% If your input file is of png or other format use this section

% Change the path to your selected file
image_path = 'TrainingData/num2set2.png';
imgRGB = imread(image_path);
img = im2bw(imgRGB, 0.5);
% Prediction the digit and printing in console
digit = guess_the_digit(img)


%% Accuracy test
%%% The following script runs the digit prediction pipeline 
%%% through all 1000 samples in "Training Data" (or "testingData")
%%% folder and calculates the accuracy statistics.

Stats = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9];
for number = 0:9
    Hit = 0;
    Miss = 0;
    for i=1:99
    %     image_path = sprintf('testingData/num%sset0size%s.png', int2str(number), int2str(47+i));
        image_path = sprintf('TrainingData/num%sset%s.png', int2str(number), int2str(i));
        imgRGB = imread(image_path);
        img = im2bw(imgRGB, 0.5);
        digit = guess_the_digit(img);
        if (digit == int2str(number))
            Hit = Hit + 1;
        else
            Miss = Miss +1;
        end
    end
    Accuracy = Hit/(Hit+Miss);
    Stats(number+1, 2) = Accuracy;
end
Stats