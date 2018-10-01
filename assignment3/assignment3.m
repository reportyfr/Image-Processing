%clear environment and command line
clear;
clc;
%choose the image
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif';}, 'please choose the image');
%if no images are picked, then the function returns
if filename == 0
    return;
end
%read the image
imgsrc = imread([pathname, filename]);
[image_y, image_x, dim] = size(imgsrc);
%transfer the source image into grey-scale image if necessary
if dim>1
    imgsrc = rgb2gray(imgsrc);
end
%smooth the image 
sigma = 3;
gausFilter = fspecial('gaussian', [3,3], sigma);
img = imfilter(imgsrc, gausFilter, 'replicate');
img = double(img);
figure(1), imshow(imgsrc);
%calculate the gradient
m = zeros(image_y , image_x);
for i=1:(image_y-1)
    for j=1:(image_x-1)
        gx =  img(i, j) + img(i+1, j) - img(i, j+1)  - img(i+1, j+1);
        gy = -img(i, j) + img(i+1, j) - img(i, j+1) + img(i+1, j+1);
        m(i,j) = (gx^2+gy^2)^0.5;
    end
end
%obtain the initial position of a contour from the user, I use ginput
%function here
%also make sure the distance between 2 points is smaller than 5 pixels, if
%not, we should add extra points
user_x=[]; user_y=[]; user_count=1; count_max=100; distance_max=5; avg_distance=0;
while user_count<count_max
    [user_xi, user_yi, button] = ginput(1);
    user_xi = round(user_xi);
    user_yi = round(user_yi);
    %make sure the diatance between 2 points is smaller than 5 pixels
    %if the distance greater than 5 pixels, add several points in between,
    %for instance, a distance of 20 pixels means we need to add 3 points
    if(user_count>=2)
        temp_distance = (double((user_xi-user_x(user_count-1))^2+(user_yi-user_y(user_count-1))))^0.5;
        temp_distance = round(temp_distance);
        temp_count = round(temp_distance/5);
        if(temp_count>=2)
            temp_x = (user_xi-user_x(user_count-1))/temp_count;
            temp_y = (user_yi-user_y(user_count-1))/temp_count;
            while(temp_count>=2)
                user_x = [user_x user_x(user_count-1)+temp_x];
                user_y = [user_y user_y(user_count-1)+temp_y];
                temp_count = temp_count-1;
                user_count = user_count+1;
            end
        end
    end
    user_x = [user_x user_xi];
    user_y = [user_y user_yi];
    hold on
    plot(user_xi, user_yi, 'ro');
    %right click to stop 
    if(button==3), break; end
    user_count = user_count+1;
end
%make the snake ring
user_xy = [user_x; user_y];
user_count = user_count+1;
user_xy(:,user_count) = user_xy(:,1);
%draw the spline
t=1:user_count;    
ts = 1:0.1:user_count;    
xys = spline(t,user_xy,ts);    
xs = xys(1,:);    
ys = xys(2,:);    
%show the result    
hold on    
temp=plot(user_x(1),user_y(1),'ro',xs,ys,'b.');
%fprintf("total points is:\n%d",user_count);

%then apply the greedy algorithm
%first define the variables
alpha = 1; beta = 1; gamma = 1; fraction = 0.1; neighboursize = 3;
move_points = 0; %points have been moved, init with 0
while(move_points<user_count*fraction)
    %first we should compute the average distance between points along the
    %sanke
    avg_distance=0;
    for i=2:(user_count-1)
        avg_diatance = avg_distance+((user_x(i)-user_x(i-1))^2+(user_y(i)-user_y(i-1))^2)^0.5;        
    end
    avg_distance = avg_distance/(user_count-1);
    for i=2:(user_count-2)
        E_min = 100000;
        j_x = user_x(i);
        j_y = user_y(i);
        for j=1:neighboursize
            current_x = user_x(i)+j-2;
            current_y = user_y(i)+j-2;
            Econt = square(avg_distance - ((user_x(i-1)-current_x)^2+(user_y(i-1)-current_y)^2)^0.5);
            Ecurv = square((user_x(i-1)-2*current_x+user_x(i+1))^2+(user_y(i-1)-2*current_y+user_y(i+1))^2);
            Eedge = -1*sqrt(m(round(current_x), round(current_y)));
            Ej = alpha*Econt + beta*Ecurv + gamma*Eedge;
            if(Ej<E_min)
                E_min = Ej;
                j_x = current_x;
                j_y = current_y;
            end
        end
        if(j_x~=user_x(i)||j_y~=user_y(i))
            move_points=move_points+1;
        end
        user_x(i)=j_x;
        user_y(i)=j_y;
    end
end
  

