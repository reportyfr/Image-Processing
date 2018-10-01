function [cb]=code_cons(img,cb,current_frame,color_dis_threshold,a1,a2)
    %get the size of the image
    [m,n,~]=size(img);
    %check every pixels in the image
    for i=1:m
        for j=1:n
            %get the current pixel
            cb_temp=cb{i,j};
            len=length(cb_temp(:,1));
            bi=sum(img(i,j,:));
            bj=sqrt(img(i,j,1)^2+img(i,j,2)^2+img(i,j,3)^2);
            %this flag is used to check whether the codeword matches
            flag=0;
            for k=1:len
                bt_res=bright_fit(bj,cb_temp(k,4),cb_temp(k,5),a1,a2);
                if((color_dist(img(i,j,:),cb_temp(k,1:3))<color_dis_threshold)&&(bt_res==1))
                    %then update the codebook
                    flag=1;
                    temp_frame=cb_temp(k,6);
                    cb{i,j}(k,:)=[(temp_frame*cb_temp(k,1)+img(i,j,1))/(temp_frame+1),(temp_frame*cb_temp(k,2)+img(i,j,2))/(temp_frame+1),(temp_frame*cb_temp(k,3)+img(i,j,3))/(temp_frame+1),min([bi,cb_temp(k,4)]),max([bi,cb_temp(k,5)]),temp_frame+1,max([cb_temp(k,7),current_frame-cb_temp(k,9)]),cb_temp(k,8),current_frame];
                    break;
                end
            end
            %the pixel does not match any codeword, we do the next
            %operation
            if (flag==0)
                cb{i,j}(len+1,:)=[img(i,j,1),img(i,j,2),img(i,j,3),bi,bi,1,current_frame-1,current_frame,current_frame];
            end
       end
    end
end