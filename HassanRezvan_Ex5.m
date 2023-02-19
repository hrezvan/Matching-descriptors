clc;
clear;
close all;

first_img = rgb2gray(imread('f_img.jpg'));
second_img = rgb2gray(imread('s_img.jpg'));
%% Step 1
[p1,q1] = harris(first_img,0.5);
% imshow(first_img)
% hold on
% scatter(q1,p1,'*r'); title('Harris for first image')

[p2,q2] = harris(second_img,0.5);
% figure;imshow(second_img)
% hold on
% scatter(q2,p2,'*r'); title('Harris for second image')
%% Step 2
descriptor_DN_1_3 = descriptor('DN',first_img,p1,q1,3);
descriptor_DN_2_3 = descriptor('DN',second_img,p2,q2,3);
[m,n] = size(first_img);
for i=1:m-1
    for j=1:n-1
        G_x_1(i,j) = double(first_img(i+1,j)-first_img(i,j));
        G_y_1(i,j) = double(first_img(i,j+1)-first_img(i,j));
        G_x_2(i,j) = double(second_img(i+1,j)-second_img(i,j));
        G_y_2(i,j) = double(second_img(i,j+1)-second_img(i,j));
    end
end
G_1 = sqrt(G_x_1.^2+G_y_1.^2);
G_2 = sqrt(G_x_2.^2+G_y_2.^2);
descriptor_Gradient_1_3 = descriptor('Gradient',G_1,p1,q1,3);
descriptor_Gradient_2_3 = descriptor('Gradient',G_2,p2,q2,3);

descriptor_moment_1_3 = descriptor('Moment',first_img,p1,q1,3);
descriptor_moment_2_3 = descriptor('Moment',second_img,p2,q2,3);

%% Step 3
[index_list,d] = Euclidian_distance(descriptor_DN_1_3,descriptor_DN_2_3);
img = [first_img second_img];
imshow(img)
hold on
plot(q1,p1,'*r');title('DN descriptor, 3*3 Window size')
hold on
plot(q2+size(first_img,2),p2,'*r')
T =1.1;
for i=1:length(d)
    if d(i) < T
        x = [q1(i) q2(index_list(i))+size(first_img,2)];
        y = [p1(i) p2(index_list(i))];
        line(x,y)
    end
end
%% Step 4
descriptor_DN_1_7 = descriptor('DN',first_img,p1,q1,7);
descriptor_DN_2_7 = descriptor('DN',second_img,p2,q2,7);
[index_list,d] = Euclidian_distance(descriptor_DN_1_7,descriptor_DN_2_7);
figure;imshow(img);title('DN, 7*7 Window size')
hold on
plot(q1,p1,'*r')
hold on
plot(q2+size(first_img,2),p2,'*r')
T = 1.1;
for i=1:length(d)
    if d(i) < T
        x = [q1(i) q2(index_list(i))+size(first_img,2)];
        y = [p1(i) p2(index_list(i))];
        line(x,y)
    end
end

descriptor_DN_1_11 = descriptor('DN',first_img,p1,q1,11);
descriptor_DN_2_11 = descriptor('DN',second_img,p2,q2,11);
[index_list,d] = Euclidian_distance(descriptor_DN_1_11,descriptor_DN_2_11);
figure;imshow(img);title('DN, 11*11 Window size')
hold on
plot(q1,p1,'*r')
hold on
plot(q2+size(first_img,2),p2,'*r')
T = 2.1;
for i=1:length(d)
    if d(i) < T
        x = [q1(i) q2(index_list(i))+size(first_img,2)];
        y = [p1(i) p2(index_list(i))];
        line(x,y)
    end
end
