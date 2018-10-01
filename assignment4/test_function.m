function [w,tsface]=test_function(average_face,sig_eigen)
    j=1;
    dirstr='/Users/junhuachen/Documents/develop/matlab/assignment4/test/';
    %get the test directory
    directory=dir(dirstr);
    for i=1:length(directory)
        if directory(i).isdir==0
            %since in MAC OS system, when modify the content of a
            %directory, '.DS_STORE' will automatically be created, I should
            %exempt this file in this lab
            if(strcmp(directory(i).name,'.DS_Store')~=1)
                %read all the images and change the images to grey images
                a=imread(strcat(dirstr,directory(i).name));
                if length(a(1,1,:))==3
                    a=rgb2gray(a);
                end
                a=double(a);
                [x,y]=size(a);
                tsface(:,j)=reshape(a,x*y,1)-average_face;
                j=j+1;
            end
        end
    end
    w=sig_eigen'*tsface;
end