function [ m, theta, area, canny1, canny2] = canny_algorithm( src, lowTh, highTh)
% inout£º
% src£ºsource image
% lowTh£ºlow threshold
% highTh: high threshold
% output:
% m: strength of the edge
% theta: direction of the edge
% area: divide the direction into 4 areas
% canny1: nonmax_suppression
% canny2: hysteresis_thresh
%--------------------------------------- 
[Ay, Ax] = size(src);
src = double(src);
m = zeros(Ay, Ax); 
theta = zeros(Ay, Ax);
area = zeros(Ay, Ax);
canny1 = zeros(Ay, Ax);
canny2 = zeros(Ay, Ax);

for y = 1:(Ay-1)
    for x = 1:(Ax-1)
        %the first step is to calculate the partial derivatives of x and y
        gx =  src(y, x) + src(y+1, x) - src(y, x+1)  - src(y+1, x+1);
        gy = -src(y, x) + src(y+1, x) - src(y, x+1) + src(y+1, x+1);
        m(y,x) = (gx^2+gy^2)^0.5 ;
        %--------------------------------
        theta(y,x) = atand(gx/gy)  ;
        temp = theta(y,x);
        %the green range
        if (temp<67.5)&&(temp>22.5)
            area(y,x) =  0;
        %the yellow range
        elseif (temp<22.5)&&(temp>-22.5)
            area(y,x) =  3;
        %the red range
        elseif (temp<-22.5)&&(temp>-67.5)
            area(y,x) =  2;
        %the blue range
        else
            area(y,x) =  1;    
        end
        %--------------------------------        
    end    
end

%nonmax_suppression
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if 0 == area(y,x) %right_top-left_bottom
            if ( m(y,x)>m(y-1,x+1) )&&( m(y,x)>m(y+1,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 1 == area(y,x) %vertical
            if ( m(y,x)>m(y-1,x) )&&( m(y,x)>m(y+1,x)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 2 == area(y,x) %left_top-right_bottom
            if ( m(y,x)>m(y-1,x-1) )&&( m(y,x)>m(y+1,x+1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 3 == area(y,x) %horizental
            if ( m(y,x)>m(y,x+1) )&&( m(y,x)>m(y,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        end        
    end
end

%hysteresis_thresh
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if canny1(y,x)<lowTh 
            canny2(y,x) = 0;
            continue;
        elseif canny1(y,x)>highTh
            canny2(y,x) = canny1(y,x);
            continue;
        %deal with the pixels that between the lowTh and highTh to detemine
        %the edges
        else
            temp =[canny1(y-1,x-1), canny1(y-1,x), canny1(y-1,x+1);
                       canny1(y,x-1),    canny1(y,x),   canny1(y,x+1);
                       canny1(y+1,x-1), canny1(y+1,x), canny1(y+1,x+1)];
            tempMax = max(temp);
            if tempMax(1) > highTh
                canny2(y,x) = tempMax(1);
                continue;
            else
                canny2(y,x) = 0;
                continue;
            end
        end
    end
end


end