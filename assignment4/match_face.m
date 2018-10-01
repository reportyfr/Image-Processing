function [temp]=match_face(training_faces,tsface,w,r,c,sig_eigen,average_face)
    w2=sig_eigen'*training_faces;
    len1=length(w2(1,:));
    len2=length(w(1,:));
    for i=1:len2
        d=zeros(1,len1);
        for j=1:len1
            d(j)=sum((w2(:,j)-w(:,i)).^2);
        end
        [~,pos]=min(d);
        b=reshape(training_faces(:,pos)+average_face,r,c);
        figure();
        imshow(uint8(b));
        b=reshape(tsface(:,i)+average_face,r,c);
        figure();
        imshow(uint8(b));
    end
end