function [rec_face]=reconstruct_face(w,tsface,sig_eigen,disp,r,c,average_face)
    rec_face=sig_eigen*w;
    if disp==1
        len=length(w(1,:));
        for i=1:len
            a=reshape(tsface(:,i)+average_face,r,c);
            figure();
            %show the image in unit8 format
            imshow(uint8(abs(a)));
    
            a=reshape(rec_face(:,i)+average_face,r,c);
            figure();
            %show the image in unit8 format
            imshow(uint8(abs(a)));
        end
    end
end