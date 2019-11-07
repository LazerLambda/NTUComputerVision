%% 1
% a)
I = imread('macritchie.jpg');

%figure, imshow(I, 'Border', 'tight');

I = rgb2gray(I);
%figure, imshow(I, 'Border', 'tight');

I = double(I);



% b)
sobel_x = [1 +2 +1; 0 0 0; -1 -2 -1]; 
sobel_y = sobel_x';

I_outx = conv2(I, sobel_x);
I_outy = conv2(I, sobel_y);

%figure, imshow(I_outx, 'Border', 'tight');
%figure, imshow(I_outy, 'Border', 'tight');

% some diagonal lines are still there visible. e.g. the path



% c)

I2 = I_outx.^2 + I_outy.^2;



% d)

threshold = 10000;
Et = I2 > threshold;

% the higher the threshold, the better the edges can be detected



% e)
tl = 0.04; th = 0.1; sigma = 1.0;
E_canny_s1 = edge(I,'canny',[tl th],sigma); 

%   i)
% different sigma values

E_canny_s2 = edge(I,'canny',[tl th],2.0);
E_canny_s3 = edge(I,'canny',[tl th],3.0);
E_canny_s4 = edge(I,'canny',[tl th],4.0);
E_canny_s5 = edge(I,'canny',[tl th],5.0);


% the higher the sigma value, the less accurate are the edges. Only the
% more visible edges ar been detected. This happens, because the higher the
% sigma, the smaller the base of the gaussian gets and so are only the
% stronger edges been detected.

%   ii)

E_canny_tl0 = edge(I,'canny',[0 th],sigma); 

% more edges become visible. 

E_canny_tl09 = edge(I,'canny',[0.09 th],sigma); 

% less edges become visible 

%% TODO


%% 2

% a)

E = E_canny_s1;



% b)

[H, xp] = radon(E);
imagesc(H);
colormap(gca,hot), colorbar

% c)
theta = 104;
radius = 157;

% d)
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;

size_E = size(E);

x = ( size_E(2) / 2 ) - B;
y = ( size_E(1) / 2 ) - A;

C = A*x + B*y; 

xl = 0;
xr = size_E(2) - 1;

yl = (C - A*xl) / B;
yr = (C - A*xr) / B;

% finding C

% e)
imshow(imread('macritchie.jpg'))
line([xl xr], [yl yr], 'LineWidth', 3.0)



%% 3 3

