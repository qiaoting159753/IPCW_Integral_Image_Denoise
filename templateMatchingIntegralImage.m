function [offsetsRows, offsetsCols, distances] = templateMatchingIntegralImage(image,row,...
    col,patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsX(1) = -1;
% offsetsY(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% This time, use the integral image method!
% NOTE: Use the 'computeIntegralImage' function developed earlier to
% calculate your integral images
% NOTE: Use the 'evaluateIntegralImage' function to calculate patch sums

%This part is implemented to avoid the exceed of indexs. The image was
%concatenated to a 3X3 image matrix.
[single_num_row,single_num_column] = size(image);

col = col + single_num_column;
row = row + single_num_row;

gray_image = cat(1,image,image);
gray_image = cat(1,image,gray_image);

nine_images = cat(2,gray_image,gray_image);
image = cat(2,gray_image,nine_images);

%REPLACE THIS
offsetsRows = zeros(searchWindowSize*searchWindowSize,1);
offsetsCols = zeros(searchWindowSize*searchWindowSize,1);
distances = zeros(searchWindowSize*searchWindowSize,1);
radius = floor(searchWindowSize/2);

counter = 1;
%For each pixel in the search window
for row_offset = -radius:radius
    for col_offset = -radius:radius
        %Record the offset
        offsetsRows(counter) = row_offset;
        offsetsCols(counter) = col_offset;
        
        trans_img = imtranslate(image,[-col_offset -row_offset]);
        diff_temp = (trans_img - image);
        diff = diff_temp .* diff_temp;
           
        Int_im = computeIntegralImage(diff);
        temp = evaluateIntegralImage(Int_im, row, col, patchSize);
        distances(counter) = temp;
        counter = counter + 1;
    end
end
end