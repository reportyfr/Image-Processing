function [dif]=differce_image(tsface,recon_face,r,c)
    dif=abs(tsface-recon_face);
    len=length(dif(1,:));
    for i=1:len
        figure();
        imshow(uint8(reshape(dif(:,i),r,c)));
    end
    d_norm=sum(dif.^2);
    figure();
    plot(ones(1,len),d_norm,'r*');
end