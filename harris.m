function [p,q] = harris(img,sigma)
yy = ones(3).*[-1;0;1];
xx = yy';
Gxy = (1/((sigma^2)*2*pi))*exp(-(xx.^2+yy.^2)/(2*sigma^2));
Gx = (1/(sigma*sqrt(2*pi)))*xx.*exp(-(xx.^2+yy.^2)/(2*sigma^2));
Gy = (1/(sigma*sqrt(2*pi)))*yy.*exp(-(xx.^2+yy.^2)/(2*sigma^2));
I_x = filter_implementation_func(img,Gx);
I_y = filter_implementation_func(img,Gy);
I_x2 = I_x.^2;
I_y2 = I_y.^2;
I_xy = I_x.*I_y;
E_1 = filter_implementation_func(I_x2,Gxy);
E_4 = filter_implementation_func(I_y2,Gxy);
E_2 = filter_implementation_func(I_xy,Gxy);
k1 = 0.05;
[m,n] = size(E_1);
for i=1:m
    for j=1:n
        M = [E_1(i,j) E_2(i,j);E_2(i,j) E_4(i,j)];
        R = det(M)-k1*(trace(M)^2);
        im(i,j) = R;
    end
end

im_vec = reshape(im,1,m*n);
sorted_im_vec = sort(im_vec,'descend');
Harris_points = sorted_im_vec(1:500);
for i=1:m
    for j=1:n
        if im(i,j) > min(Harris_points)
           im(i,j) = max(Harris_points)*10; 
        end
    end
end
[p,q] = find(im == max(Harris_points)*10);

end