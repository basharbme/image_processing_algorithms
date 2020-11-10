# Image Processing Algorithms

### Nearest Neighbor Interpolation

Implementations of first exercise were based on inverse interpolation as was discussed in class. This included creating new empty images, iterating through all values, mapping these values back to original image and depending on the interpolation technique either remap value for Nearest-Neighbors, compute weighted average for Bilinear or compute weighted average of 16 neighbors for Bicubic interpolations.
One point worth noting in this exercise was implementation of weighted averaging based on distance of the pixels. This included simply having a list of weights which was then multiplied by the intensity of the pixel and summed up. Afterwards, everything was divided by total weight to normalize the images. Weights for neighbors were found by test and trial and can be simply modified. They were chosen in a way to replicate gaussian distribution. Nevertheless the results are very satisfactory and are shown in Fig. 1. As it can be seen, the original zoomed image shown by MATLAB imshow is using the NN interpolation for zooming images. Furthermore, it can be observed that bilinear shows smoother image, but bicubic is even smoother for diagonal lines and shows best smoothing.

![](./images/1.png)

Fig. 1. Various interpolation techniques shown on image zoomed two times.

### Distance Transform and Skeletonization

As the implementation of the third task was based on the second, it was decided to merge them into one MATLAB script. Aim of the second task was to implement the Distance Transform which aims to find image representation based on pixel distances from the corners. Implementation was based on first computing the corner pixels and counting the total number of foreground pixels. Afterwards, the task was finding 8-neighbors of border pixels and incrementing the value. As the values of all foreground pixels became non-zero, the loop terminated. Finally, the distance image was normalized with regard to maximum value being proportional to 256.

In the Skeletonization, as was mentioned in exercise, boundary pixels which had background pixels in their East and North OR West and North OR East and South OR West and South neighborhoods were marked as corner points. Afterwards, maximum pixel in their 8-neighborhood was marked and the process continued until convergence for each corner point. The results of both distance transform and skeletonization for rectangle with rounded corners shown in Fig. 1. and Facebook binary logo is shown in Fig. 2. As it can be seen, skeletonization algorithm is very sensitive to rounded corners because it finds corner pixels only locally for each pixel, therefore for rounded parts there are several paths from rounded parts to central “skeleton”.

![](./images/2.png)

Fig. 2. Distance transform and skeletonization algorithms used on rectangle with rounded corners

![](./images/3.png)

Fig. 3. Distance transform and skeletonization algorithms used on Facebook logo
