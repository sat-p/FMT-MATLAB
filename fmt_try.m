clc;
clear;

hold on;

%generating new sample points with uniform probablity
n = 10000;
sample_point = rand(n-2,2);
sample_point = 100*sample_point;

% start and goal points
srt_p = [90,10];
gol_p = [60,40];

% scatter(sample_point(:,1),sample_point(:,2),'r');
scatter (gol_p (1), gol_p (2), 'r');
sample_point = make_obstacle(sample_point); % function called to make obstacle
                                            % and remove random points
                                            % inside obstacle
V_nv = [sample_point;gol_p];  % V not visited
V_open = srt_p;
V_close = [];
sample_point = [srt_p;V_nv];
endP = length(sample_point);

z = srt_p; % minimum cost point from origin at start
cost_open = 0;
root = [1 1];
index_nv = 2:size(sample_point,1); % index of points of V_nv in sample_point
index_open = 1; % index of V_open points in sample_point


z_index = 1;
flag = true; % a flag that will be 0 when program will end

while flag == true
    index_x = get_x(sample_point,index_nv,z); %index of x in sample_point
    l = length(index_x);
    for i = 1:l  %getting y points for each x
        [index_y, dist, j] = get_y (sample_point,...
                                    index_open,...
                                    index_x (i)); % index of y point in
                                                  % sample_point & distance
                                                  % from x
         %% checking the line joining x point and y points intersects with obstacle
%         flag2 = checkobs_fmt(sample_point(index_y,:),sample_point(index_x(i),:));
%         if flag2 == 0 % flag2 =0 if it intersects with obstacle
%             continue;
%         end
        %% linking the y point index with its root's index in sample_point
        root_indx = [index_x(i) find(root(:,1)==index_y)];
        root = [root; root_indx];
        
        index_nv(index_nv == index_x(i)) = []; %removing y from V_nv index
        %index_open = [index_open;index_x(i)];  %adding y in V_open index
        dist = cost_open(j) + dist;
        cost_open = [cost_open; dist];  % saving cost for each y points
        
        %% Plotting added edge
        points = [sample_point(index_x(i),1),sample_point(index_y,1);
                  sample_point(index_x(i),2),sample_point(index_y,2)];
        plot(points(1,:),points(2,:),'c')
%         pause(.000001)
%         alpha(.5)
        
        %% Checking if x is the goal.
        if index_x(i) == endP
            disp ('Found goal');
            flag = false;
        end
    end
    
    index_open(z_index) = [];
    cost_open(z_index) = [];
    index_open = [index_open index_x];
    
    %% Checking in V_open is empty
    if isempty(index_open)
        disp ('V_open is empty');
        flag = false;
    end
    
    %% Retreiving lowest code node from V_open
    [~, z_index] = min(cost_open);
    z_index = z_index (1);
    
    z_sample_idx = index_open(z_index);
    z = sample_point(z_sample_idx,:);
end

%% Tracing path from goal to start point

i = size(root, 1);
path = [];
child_sample_idx = 1;

while flag == false
    child_sample_idx = root(i, 1); 
    path = [path; sample_point(child_sample_idx, :)];
    i = root(i,2);
    if root(i,:) == [1 1]
        flag = true;
        path = [path; srt_p];
    end
end

% Plotting path from start to goal
plot(path(:,1),path(:,2),'r', 'LineWidth', 2)