function img_f=gaufilter(img,m,t)
a=1:m;
f=exp((a-m/2).^2/(2*t^2));
f=round(f/min(f));
sf=sum(f);
img1=conv2(img,f,'same');
img_f=uint8(conv2(img1,f','same')/(sf^2));
imshow(img_f);
end