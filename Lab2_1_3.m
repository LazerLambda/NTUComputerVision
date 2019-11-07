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