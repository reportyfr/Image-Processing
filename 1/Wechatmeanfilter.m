function img_f=meanfilter(img1,m)
f=ones(m)/(m^2);
img_f=uint8(conv2(img1,f,'same'));
imshow(img_f);
end