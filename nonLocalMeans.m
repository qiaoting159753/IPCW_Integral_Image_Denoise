function [result] = nonLocalMeans(image, sigma, h, patchSize, windowSize)
result = zeros(size(image));

[num_row,num_column] = size(image);
radius = floor(windowSize/2);
extendSize = floor(patchSize/2)+radius;
extendPatchImg = padarray(image,[extendSize,extendSize],'symmetric','both');

%Store the offset and Integral Image
offsetsRows = zeros(windowSize*windowSize,1);
offsetsCols = zeros(windowSize*windowSize,1);

counter = 1;
%For each possible offset,compute the integral image first 
for row_offset = -radius:radius
    for col_offset = -radius:radius
        %Record the offset
        offsetsRows(counter) = row_offset;
        offsetsCols(counter) = col_offset;
        
        %translate image with offset.
        trans_img = imtranslate(extendPatchImg,[-col_offset -row_offset]);
        diff_temp = (trans_img - extendPatchImg);
        diff = diff_temp .* diff_temp;
           
        Int_im{counter} = computeIntegralImage(diff);
        counter = counter + 1;
    end
end

%For each pixel in the image
for row_index = 1:num_row
    for col_index = 1:num_column
        col = col_index + extendSize;
        row = row_index + extendSize;
        %For each Integral Image, evaluate the distance
        d = zeros(counter-1,1);
        sumOfWeight = 0;
        weighted_sum = 0;
        for int_counter = 1:counter-1
            d(int_counter) = evaluateIntegralImage( Int_im{int_counter},row,col,patchSize);
            weights = computeWeighting(d(int_counter),h,sigma,patchSize);
            sumOfWeight = sumOfWeight + weights;
            weighted_sum = weighted_sum + weights * extendPatchImg(row + offsetsRows(int_counter),col + offsetsCols(int_counter));
        end
        result(row_index,col_index) = weighted_sum/sumOfWeight;
    end
end

end