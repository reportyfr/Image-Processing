%pca function for this project
function [sig_eigen,eigen_face,running_time]=pca_function(training_faces,num)
    %get the running time
    tic;
    len=length(training_faces(1,:));
    %do the PCA algorithm
    a=training_faces*training_faces'/(len-1);
    [eigen_face,~]=eig(a);
    toc;
    running_time=toc;
    %print the running time
    fprintf("Total running time is %ds.\n", running_time);
    len2=length(eigen_face(1,:));
    sig_eigen=eigen_face(:,len2-num+1:len2);
end