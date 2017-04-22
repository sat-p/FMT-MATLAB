function [index,min_dist,j] = get_y(sample,indx,point)
l = length(indx);
k = 1;
for i = 1:l
    disp = sample(indx(i),:)-sample(point,:);
    dist(i) = disp(1)^2+disp(2)^2;
end
% for i = 2:l
%     if dist(i) < dist(i-1)
%         index = indx(i);
%         cost = dist(i);
%     else
%         index = indx(i-1);
%         cost = dist(i-1);
%     end
% end

[min_dist, i] = min(dist);
% i = find(dist == min_dist);
j = i;
index = indx (i (1));        