%this function is used for copying images to train directory and test
%directory
function [] = copy_image(option)
    dir1 = '/Users/junhuachen/Documents/develop/matlab/assignment4/train/';
    dir2  = '/Users/junhuachen/Documents/develop/matlab/assignment4/test/';
    dir3 = '/Users/junhuachen/Documents/develop/matlab/assignment4/yalefaces_centered_small/';
    %define the number of imgaes in test and train directory
    count = 10;
    switch option
        %0 stands for copying images to train directory manully
        case 0
            [filename, pathname] = uigetfile({'*'}, 'please choose the image');
            copyfile([pathname, filename], dir1);
        %1 stands for copying file to test directory
        case 1
            [filename, pathname] = uigetfile({'*'}, 'please choose the image');
            copyfile([pathname, filename], dir2);
        %pick random images and copy it to corresponding directories
        case 2
            %get the dataset path
            directory = dir(dir3);
            len = length(directory);
            random1 = 1+(len-1)*rand(1,count);
            random2 = 1+(len-1)*rand(1,count);
            for i=0:count
                copyfile(strcat(dir3,directory(random1(i))),dir1);
                copyfile(strcat(dir3,directory(random2(i))),dir2);
            end
    end
            