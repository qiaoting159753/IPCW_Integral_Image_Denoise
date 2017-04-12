%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 100;
col = 100;

% Patchsize - make sure your code works for different values
patchSize = 3;

% Search window size - make sure your code works for different values
searchWindowSize = 3;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
image = imread('images/hello.jpg');
temp_image = rgb2gray(image);
temp_image = im2double(temp_image);

% TODO - Fill out this function
image_ii = computeIntegralImage(temp_image);

% TODO - Display the normalised Integral Image
% NOTE: This is for display only, not for template matching yet!
figure('name', 'Normalised Integral Image');
image_ii = double(image_ii./image_ii(size(image_ii,1),size(image_ii,2)));
imshow(image_ii);

% TODO - Template matching for naive SSD (i.e. just loop and sum)
 [offsetsRows_naive, offsetsCols_naive, distances_naive] = templateMatchingNaive(temp_image,row, col,...
     patchSize, searchWindowSize);

% TODO - Template matching using integral images
[offsetsRows_ii, offsetsCols_ii, distances_ii] = templateMatchingIntegralImage(temp_image,row, col,...
    patchSize, searchWindowSize);

%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for i=1:length(offsetsRows_naive)
     disp(['offset rows: ', num2str(offsetsRows_naive(i)), '; offset cols: ',...
         num2str(offsetsCols_naive(i)), '; Naive Distance = ', num2str(distances_naive(i),10),...
         '; Integral Im Distance = ', num2str(distances_ii(i),10)]);
end