function [index] = get_x(sample,indx,point)
l = length(indx);
index = [];
k = 1;
for i = 1:l
    disp = sample(indx(i),:)-point;
    dist = disp(1)^2+disp(2)^2;
    if dist < 18.42 % 2.3025 for n = 100000
                    %18.42 %for n = 10000
                    %138 Calculated for n = 1000
        index(k) = indx(i);
        k = k+1;
    end
end
% TODO : change the distance threshold based on the number of samples
% as given in the paper