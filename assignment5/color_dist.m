function [color_distance]=color_dist(x,v)
    color_distance=sqrt(x(1)^2+x(2)^2+x(3)^2-((x(1)*v(1)+x(2)*v(2)+x(3)*v(3))^2)/(v(1)^2+v(2)^2+v(3)^2));
end