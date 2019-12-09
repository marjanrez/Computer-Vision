%Final project Computer Vision

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
fontSize = 15;

%Now, let's gain the intensity with equal weight
pic='https://raw.githubusercontent.com/marjanrez/Computer-Vision/master/18.bmp';
%pic = 'https://www.soundaway.com/v/vspfiles/assets/images/doorframekitmed.jpg';
%pic = '/Users/marjanrezvani/Desktop/2.bmp';
C1 = imread(pic);
imshow(C1);
[ROWS COLS CHANNELS] = size(C1);
I1    = uint8(round(sum(C1,3)/3));
%No2 = figure('Name','equal average');  % Figure No. 2
%image(I1);
MAP =zeros(256, 3);

for i = 1 : 256,
    for band = 1:CHANNELS,
        MAP(i,band) = (i-1)/255;
    end
end

colormap(MAP);
figure;
imshow(I1)


if length(size(i)) == 3
    im =  double(i(:,:,2));
else
    im = double(i);
end

[~,threshOut]=edge(I1,'Canny');
threshold = threshOut*2.0;
BW1 = edge(I1,'Canny',threshold);
figure;
imshow(BW1)
[H,theta,rho] = hough(BW1);
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho);
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on; colormap(hot) 
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); 
x = theta(P(:,2)); y = rho(P(:,1)); plot(x,y,'s','color','black');
lines = houghlines(BW1,theta,rho,P,'FillGap',5,'MinLength',7); 
figure, imshow(I1), hold on;
max_len = 0;
for k = 1:length(lines) 
    xy = [lines(k).point1; 
        lines(k).point2]; 
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

% Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%


