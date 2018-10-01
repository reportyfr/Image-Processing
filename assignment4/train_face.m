function [sig_eigen,class_face,average_face,training_faces]=train_face(num,ind)
    switch ind
        case 1
            [sig_eigen,~,~]=pca_function(training_faces,num);
        case 2
            [sig_eigen,~,~]=svd_function(training_faces,num);
        otherwise
            [sig_eigen,~,~]=tp_function(training_faces,num);
    end

    class_face=sig_eigen'*training_faces;

end