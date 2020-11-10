1) Open "Testing_Main.m" script in MATLAB
2) Run the code, which basically consists of two scripts: 
    - First is implemented to predict the provided sample digit image and to print the prediction.
    - Second script runs through all 1000 samples in "Training Data" folder (100 samples for each of 10 digits) 
      and calculates the prediction accuracy scores for each digit.

  *The scripts in the pipeline include: crop_n_resize.m, interpolation_resize.m, distance_arrays.m and guess_the_digit.m;
 **The script outer_border.m was written to do boundary tracing of a digit, but was discarded from the pipeline in the
   development process.
***Other scripts are used only for testing.