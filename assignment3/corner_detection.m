%this function is used for corner detection
function [bb,dm]=corner_detection(con_p,img_grad,t1,t2)
    %get the size
    size=length(con_p(1,:));
    corn=zeros(1,n);
    u1=con_p(:,1)-con_p(:,size);
    u1m=sqrt(sum(u1.^2));
    u2=con_p(:,2)-con_p(:,1);
    u2m=sqrt(sum(u2.^2));
    corn(1)=sum((u1/u1m+u2/u2m).^2);
    d=u1m;
    for i=2:size-1
        u1=con_p(:,i)-con_p(:,i-1);
        u1m=sqrt(sum(u1.^2));
        u2=con_p(:,i+1)-con_p(:,i);
        u2m=sqrt(sum(u2.^2));
        corn(i)=sum((u1/u1m+u2/u2m).^2);
        d=d+u1m;
    end
    u1=con_p(:,size)-con_p(:,size-1);
    u1m=sqrt(sum(u1.^2));
    u2=con_p(:,1)-con_p(:,size);
    u2m=sqrt(sum(u2.^2));
    corn(size)=sum((u1/u1m+u2/u2m).^2);
    d=d+u1m;
    dm=d/size;
    %normalization the matrix
    corn=[corn(size),corn,corn(1)]/max(corn);
    bb=ones(1,size);
    %mark the corner
    for i=1:size
        if (corn(i+1)>max([corn(i),corn(i+2),t1])) && (img_grad(con_p(1,i),con_p(2,i))>t2)
           bb(i)=0;
        end
    end
end