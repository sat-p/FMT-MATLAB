function sample_point = make_obstacle(sample)
%% obstacles
x1 = [20,80,80,50,50,70,70,20];
y1 = [20,20,60,60,50,50,30,30];
x2 = [10,30,30,20,20,10];
y2 = [50,50,60,60,90,90];
patch(x1,y1,'g')
patch(x2,y2,'g')
%%
a = sample(:,1); % x points
b = sample(:,2);  % y points
[in on] = inpolygon(a,b,x1,y1); %checking insiders points

a(in) = []; %removing insiders points
b(in) = [];
[in on] = inpolygon(a,b,x2,y2); %checking insiders points

a(in) = []; %removing insiders points
b(in) = [];
 
sample_point = [a b]; %concatnation remaining x y points



