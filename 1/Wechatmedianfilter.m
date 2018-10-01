function img_f=medianfilter(img,m)
[x,y]=size(img);
img_f=img;
for i=1:x
    for j=1:y
   l1=max([1,round(i-(m-1)/2)]);
   l2=max([1,round(j-(m-1)/2)]);
   h1=min([x,round(i+(m-1)/2)]);
   h2=min([y,round(j+(m-1)/2)]);
   f=img(l1:h1,l2:h2);
   [x0,y0]=size(f);
   num=x0*y0;
   m1=sort(reshape(f,1,num));
   img_f(i,j)=m1(round(num/2));
    end
end
img_f=uint8(img_f);
imshow(img_f);

end