function [ii] = computeIntegralImage(image)

im_size = size(image);
ii = zeros(size(image));

ii(1,1) = image(1,1);

for first_row = 2:im_size(2)
    ii(1,first_row) = ii(1,first_row-1) + image(1,first_row);  
end

for first_column = 2:im_size(1)
    ii(first_column,1) = ii(first_column-1,1) + image(first_column,1);  
end

for row = 2:im_size(1)
    for column = 2:im_size(2)         
        ii(row,column) = ii(row-1,column) + helper_row_sum(image,row,column);
    end
end
   
end

function row_sum = helper_row_sum(image,row,column)
    row_sum = 0;
    for index = 1:column
        row_sum = row_sum + image(row,index);
    end
end