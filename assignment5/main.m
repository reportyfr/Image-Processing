function [subtraction_result,morph_result,bg_cb]=main(color_dis_threshold,color_dis_threshold_two,alpha,beta,tm_threshold,disp,local_cb,bg_cb)
    %define the path in my computer
    directory=dir('/Users/junhuachen/Documents/develop/matlab/assignment5/test');
    j=1;
    k=1;
    if(local_cb==0)
        [bg_cb]=codebook_training_function(color_dis_threshold,alpha,beta,tm_threshold);
    end
    for i=1:length(directory)
        if(directory(i).isdir==0)
            %double the image
            a=double(imread(directory(i).name));
            % call the background subtraction function here
            subtraction_result{j}=background_subtraction(a,bg_cb,color_dis_threshold_two,alpha,beta);        
            binary_img=imbinarize(subtraction_result{j});
            %do the morphological operations here
            SE=strel('disk',1);
            binary_img=imopen(binary_img,SE);
            binary_img=imclose(binary_img,SE);
            morph_result{j}=uint8(binary_img*255);
            if(j==disp(k))
                %show the result here
                figure();
                imshow(subtraction_result{j});
                figure();
                imshow(morph_result{j});
                if k<length(disp)
                    k=k+1;
                end
            end
            j=j+1;
        end    
    end
end