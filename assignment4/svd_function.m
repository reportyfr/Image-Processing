%this is the SVD function 
function [sig_eigen,eigen_face,runningtime]=svd_function(training_faces,num)
    %tic & toc is uesd to calculate the running time
    tic;
    n=length(training_faces(1,:));
    %do SVD process, use built-in function
    a=training_faces'/(sqrt(n-1));
    [~,~,eigen_face]=svd(a);
    toc;
    runningtime=toc;
    fprintf("Total running time is %ds.\n", runningtime);
    sig_eigen=eigen_face(:,1:num);
end