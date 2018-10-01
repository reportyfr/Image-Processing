function [background_cb]=codebook_training_function(color_dis_threshold,alpha,beta,MNRL_threshold)
    %points to the first frame 
    frame_number=1;
    %the path of the train folder in my computer
    di=dir('/Users/junhuachen/Documents/develop/matlab/assignment5/train');
    for i=1:length(di)
        if(di(i).isdir==0)
            %read all the training images
            a=double(imread(di(i).name));
            [m,n,~]=size(a);
            %initialize the first image
            if(frame_number==1)
                cb=cell(m,n);
                for row=1:m
                    for col=1:n
                        cb{row,col}=[a(row,col,1),a(row,col,2),a(row,col,3),sum(a(row,col,:)),sum(a(row,col,:)),1,frame_number-1,frame_number,frame_number];
                    end
                end
            %call the function to deal with the rest images
            else
                cb=code_cons(a,cb,frame_number,color_dis_threshold,alpha,beta);
            end
            frame_number=frame_number+1;
        end
    end
    %define the total frame number(the number of training images)
    frame_total=frame_number-1;
    %get the size
    [m,n]=size(cb);
    background_cb=cell(m,n);
    for i=1:m
        for frame_number=1:n
            cw=cb{i,frame_number};
            len=length(cw(:,1));
            count=1;
            for t=1:len
                lmd=max([cw(t,7),frame_total-cw(t,9)+cw(t,8)-1]);
                %choose out the background codeword
                if(lmd<frame_total*MNRL_threshold)
                    background_cb{i,frame_number}(count,:)=cw(t,:);
                    background_cb{i,frame_number}(count,7)=lmd;
                    count=count+1;
                end
            end        
        end
    end
end