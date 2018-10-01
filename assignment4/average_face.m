function [average_face, training_faces]=average_face()
    %set the path of train directory
    dirstr='/Users/junhuachen/Documents/develop/matlab/assignment4/train/';
    directory=dir(dirstr);
    count=1;
    for i=1:length(directory)
        if directory(i).isdir==0
            %since in MAC OS system, when modify the content of a
            %directory, '.DS_STORE' will automatically be created, I should
            %exempt this file in this lab
            if(strcmp(directory(i).name,'.DS_Store')~=1)
                fprintf("%s\n",directory(i).name);
                a=imread(strcat(dirstr,directory(i).name));
                %change the image into grey image
                if length(a(1,1,:))==3
                    a=rgb2gray(a);
                end
                a=double(a);
                %get the size of the image
                [x,y]=size(a);
                training_faces(:,count)=reshape(a,x*y,1);
                count=count+1;
            end
        end
    end
    average_face=mean(training_faces,2);
    for i=1:(count-1)
        training_faces(:,i)=training_faces(:,i)-average_face;
    end
    %show the average face
    imshow(uint8(reshape(average_face,x,y)));

end