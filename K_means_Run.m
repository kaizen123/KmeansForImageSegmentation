function [time, count,m] = K_means_Run(Img,k)
h = waitbar(0,'Please wait ...');
tic;
count = 0;
m = double(Img);
[maxRow,maxCol,rgb] = size(m); 
% initial value of centroid 
c = zeros(1,k,rgb);
for i = 1:k 
    c(1,i,:)= m(i,i,:);  
end

temp = zeros(maxRow,maxCol); % initialize as zero vector

while(1)
    waitbar(count/100);
    d=DistMatrix(m,c); % calculate objcets-centroid distances 
    [z,g]=min(d,[],3); % find group matrix g 
    if(g == temp)
        for i = 1:k
            [x,y] = find(g == i);
            num = size(x,1);
            for j = 1:num
                m(x(j),y(j),:) = c(1,i,:);
            end
        end
        break; % stop the iteration 
    else 
        count = count + 1;
        temp=g; % copy group matrix to temporary variable 
        % Recalculate the centroids
        c = zeros(1,k,rgb);
        for i = 1:k
            [x,y] = find(g == i);
            num = size(x,1);
            for j = 1:num
                c(1,i,:) = c(1,i,:) + m(x(j),y(j),:)/num;
            end
        end
    end 
end 
time = toc;
close(h); 
