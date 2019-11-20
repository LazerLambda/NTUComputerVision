%% 1
% a)
I = imread('macritchie.jpg');

I = rgb2gray(I);
figure, imshow(I, 'Border', 'tight');
print('I','-dpng');
figure, imshow(I, 'Border', 'tight');

I = double(I);



% b)
sobel_x = [
      1 +2 +1; 
      0  0  0; 
     -1 -2 -1]; 
sobel_y = sobel_x';

I_outx = conv2(I, sobel_x);
I_outy = conv2(I, sobel_y);

figure, imshow(I_outx, 'Border', 'tight');
print('I_outx','-dpng');
figure, imshow(I_outy, 'Border', 'tight');
print('I_outy','-dpng');

% some diagonal lines are still there visible. e.g. the path


% c)

I2 = I_outx.^2 + I_outy.^2;
imshow(I2, 'Border', 'tight');
print('I2','-dpng');


% d)
threshold = 1000;
Et = I2 > threshold;
imshow(Et, 'Border', 'tight');
print('Et1000','-dpng');

threshold = 10000;
Et = I2 > threshold;
imshow(Et, 'Border', 'tight');
print('Et10000','-dpng');

threshold = 100000;
Et = I2 > threshold;
imshow(Et, 'Border', 'tight');
print('Et100000','-dpng');

% the higher the threshold, the better the edges can be detected



% e)
tl = 0.04; th = 0.1; sigma = 1.0;
E_canny_s1 = edge(I,'canny',[tl th],sigma);
imshow(E_canny_s1, 'Border', 'tight');
print('E_canny_s1','-dpng');

%   i)
% different sigma values

E_canny_s2 = edge(I,'canny',[tl th],2.0);
imshow(E_canny_s2, 'Border', 'tight');
print('E_canny_s2','-dpng');

E_canny_s3 = edge(I,'canny',[tl th],3.0);
imshow(E_canny_s3, 'Border', 'tight');
print('E_canny_s3','-dpng');

E_canny_s4 = edge(I,'canny',[tl th],4.0);
imshow(E_canny_s4, 'Border', 'tight');
print('E_canny_s4','-dpng');

E_canny_s5 = edge(I,'canny',[tl th],5.0);
imshow(E_canny_s5, 'Border', 'tight');
print('E_canny_s5','-dpng');



% the higher the sigma value, the less accurate are the edges. Only the
% more visible edges ar been detected. This happens, because the higher the
% sigma, the smaller the base of the gaussian gets and so are only the
% stronger edges been detected.

%   ii)

E_canny_tl0 = edge(I,'canny',[0 th],sigma);
imshow(E_canny_tl0, 'Border', 'tight');
print('E_canny_tl0','-dpng');


% more edges become visible. 

E_canny_tl09 = edge(I,'canny',[0.09 th],sigma);
imshow(E_canny_tl09, 'Border', 'tight');
print('E_canny_tl09','-dpng');

% less edges become visible 



%% 2

% a)

E = E_canny_s1;

% b)
thetasc = 0:179;
[H, xp] = radon(E);

% display the Hough domain
figure, imagesc(thetasc, xp, H);
colormap(gca,hot), colorbar;

% c)
% get the indices of the maximum of the votes
[Value,Ind] = max(H(:));
[radius,theta] = ind2sub(size(H),Ind);
radius = xp(radius);

% get the size of the 
[size_Ey, size_Ex] = size(E);

% d)
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;

% get x and y coordinates
x = A + size_Ex / 2; 
y = B + size_Ey / 2;


% get the gradient of the line
dx = B / A;

% get the constant
c = y - (A / B * -1)* x;

% e)
if c == -Inf || c == Inf
    % special case if theta = 0° or theta = 180° 
    yl = 0;
    yr = size_Ey - 1;
    xl = x;
    xr = x;
else
    % since the constant is known,
    xl = 0;
    xr = size_Ex - 1;
    yl = c;
    yr = c + (A / B * -1)* size_Ex;
end


% f)
% display image
imshow(imread('macritchie.jpg'), 'Border', 'tight');
line([xl xr], [yl yr], 'LineWidth', 3.0);
print('macritchie_line_disp','-dpng');




%% 3 3 Stereo Vision

% b) 
Left_I      = imread('corridorl.jpg');
Right_I     = imread('corridorr.jpg');

Left_I = rgb2gray(Left_I);
Right_I = rgb2gray(Right_I);

disparityMap = dispfunc(Left_I, Right_I, 11, 11);

% c)
figure, imshow(disparityMap, [-15 15], 'Border', 'tight');
print('corridor_disp','-dpng')

% d)
Left_II      = imread('triclopsi2l.jpg');
Right_II     = imread('triclopsi2r.jpg');

Left_II      = rgb2gray(Left_II);
Right_II     = rgb2gray(Right_II);

disparityMap = dispfunc(Left_II, Right_II, 11, 11);
figure, imshow(disparityMap, [-15 15], 'Border', 'tight');
print('triclopsi_disp','-dpng')

