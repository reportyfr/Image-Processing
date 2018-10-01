function [subtraction_result]=background_subtraction(img,bg_cb,color_dis_threshold,alpha,beta)
    %get the size of the image
    [x,y,~]=size(img);
    %initialize the result matrix
    subtraction_result=zeros(x,y);
    for i=1:x
        for j=1:y
            codeword=bg_cb{i,j};
            [t,~]=size(codeword);
            flag=0;
            for k=1:t
                %deal with the background pixels
                if (color_dist(img(i,j,:),codeword(k,1:3))<color_dis_threshold)&&(bright_fit(sqrt(img(i,j,1)^2+img(i,j,2)^2+img(i,j,3)^2),codeword(k,4),codeword(k,5),alpha,beta)==1)
                    flag=1;
                    break;
                end
            end
            if flag==0
                %make it white color
                subtraction_result(i,j)=255;
            end
        end
    end
    %transfer the result in unit8 format
    subtraction_result=uint8(subtraction_result);
end