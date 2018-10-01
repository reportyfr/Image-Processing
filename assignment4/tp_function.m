function [sig_eigen,eigen_face,running_time]=tp_function(training_faces,num)
    % get the running time
    tic;    
    [v,~]=eig(training_faces'*training_faces);
    eigen_face=training_faces*v;
    %normalization
    normal=sqrt(sum(eigen_face.^2));
    %do tp function
    for i=1:length(eigen_face(1,:))
        eigen_face(:,i)=eigen_face(:,i)/normal(i);
    end
    toc;
    running_time=toc;
    fprintf("Total running time is %ds.\n", running_time);
    n=length(eigen_face(1,:));
    sig_eigen=eigen_face(:,n-num+1:n);
end