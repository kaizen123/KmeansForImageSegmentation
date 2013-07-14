function [temp_img,g_matrix,c]=K_means_Begin(Img,k)
m = double(Img);
temp_img = m;
[maxRow,maxCol,rgb]=size(m); 

% initial value of centroid 
c = zeros(1,k,rgb);
for i = 1:k 
    c(1,i,:) = m(i,i,:);  
end 

d = DistMatrix(m,c); % calculate objcets-centroid distances 
[z,g] = min(d,[],3); % find group matrix g 
g_matrix = g; % copy group matrix to temporary variable 
% Recalculate the centroids
c = zeros(1,k,rgb);
for i = 1:k
    [x,y] = find(g == i);
    num = size(x,1);
    for j = 1:num
        temp_img(x(j),y(j),:) = c(1,i,:);
    end
    for j = 1:num
        c(1,i,:) = c(1,i,:) + m(x(j),y(j),:)/num;
    end
end

