function [class_res]=classify_face(sig_eigen,class_face,average_face,training_faces,ef1,ef2,r,c)
    [w,tsface]=test_projection(average_face,sig_eigen);
    len1=length(class_face(1,:));
    len2=length(w(1,:));
    rec_face=recon_face(w,tsface,sig_eigen,0,1,1,average_face);

    error1=sum((tsface-rec_face).^2)./(sum(tsface.^2));
    class_res=zeros(1,len2);


    for i=1:len2
        if error1(i)>ef1
            class_res(i)=-1;
            fprintf('Face %d is not a face!\n',i);
        else
            error2=zeros(1,len1);
            for j=1:len1
                error2(j)=sum((w(:,i)-class_face(:,j)).^2)/((sum(w(:,i).^2)+sum(class_face(:,j).^2))*0.5);
            end
            [er2,pos]=min(error2);
            if er2>ef2
                class_res(i)=0;
                fprintf('Unknow face %d!\n',i);
            else
                class_res(i)=pos;
                fprintf('Face %d and Face %d are most likely to be the same face.\n',i,class_res(i));
        
                figure();
                aface_processed=reshape(average_face+training_faces(:,pos),r,c);
                imshow(uint8(aface_processed));
                figure();
                aface_processed=reshape(average_face+tsface(:,i),r,c);
                imshow(uint8(aface_processed));
            end
        end

    end

end