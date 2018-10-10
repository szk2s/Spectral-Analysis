function result = normalizeMatrix(matrix)
    ratio = 1/max(matrix(:));
    result = matrix * ratio;
end

