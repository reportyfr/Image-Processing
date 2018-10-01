function [brightness]=bright_fit(b1,min,max,alpha,beta)
    b_low=alpha*min;
    b_hig=min([beta*max,min/alpha]);
    %according to the definition of brightness
    if (b1<b_hig)&&(b1>b_low)
        brightness=1;
    else
        brightness=0;
    end
end