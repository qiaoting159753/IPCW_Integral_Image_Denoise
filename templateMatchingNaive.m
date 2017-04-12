function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(image, row, col,...
    patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

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
radius = floor(searchWindowSize/2);
offsetsRows = zeros(searchWindowSize*searchWindowSize,1);
offsetsCols = zeros(searchWindowSize*searchWindowSize,1);
distances = zeros(searchWindowSize*searchWindowSize,1);

counter = 1;
%For each pixel in the search window
for row_offset = -radius:radius
    for col_offset = -radius:radius
        %Record the offset
        offsetsRows(counter) = row_offset;
        offsetsCols(counter) = col_offset;
        
        %Calculate the pixel at the centre of each patch which is at (row_index,column_index)
        patch_radius = floor(patchSize/2);
        
        total = 0;
        for patch_row = -patch_radius:patch_radius
            for patch_col = -patch_radius:patch_radius
                org_value = image(row+patch_row,col+patch_col);
                off_value = image(row + row_offset + patch_row,col+patch_col + col_offset);
                diff = org_value - off_value;
                total = total + diff^2;
            end
        end

        distances(counter) = total;
        counter = counter + 1;
    end
end
end