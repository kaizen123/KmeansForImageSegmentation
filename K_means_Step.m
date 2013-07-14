function [temp_img,g_matrix,c]=K_means_Step(Img,k,c,g_matrix)
m = double(Img);
temp_img = m;
[maxRow,maxCol,rgb] = size(m); 

d = DistMatrix(m,c); % calculate objcets-centroid distances 
[z,g] = min(d,[],3); % find group matrix g 

if(g == g_matrix)
     warndlg(sprintf('We have reached the destination'));
else
    g_matrix = g; % copy group matrix to temporary variable 
    % Recalculate the centroids
    for i = 1:k
        [x,y] = find(g == i);
        num = size(x,1);
        for j = 1:num
            temp_img(x(j),y(j),:) = c(1,i,:);
        end
        c(1,i,:) = zeros(1,1,rgb);
        for j = 1:num
            c(1,i,:) = c(1,i,:) + m(x(j),y(j),:)/num;
        end
    end
end

