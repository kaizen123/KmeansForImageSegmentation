function d = DistMatrix(A,B) 
% A is the image
% B are the centroids
[row,col,rgb] = size(A);
[r,c,rgb] = size(B);
d = zeros(row,col,c);
for i = 1:c
    temp = zeros(row,col,rgb);
    for j = 1:rgb
        temp(:,:,j) = A(:,:,j) - B(1,i,j);
    end
    d(:,:,i) = sqrt(sum(temp.^2,3));
end
