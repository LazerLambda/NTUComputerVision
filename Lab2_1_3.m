Left_I      = imread('corridorl.jpg');
Right_I     = imread('corridorr.jpg');

Left_I = rgb2gray(Left_I);
Right_I = rgb2gray(Right_I);

disparityMap = dispfunc(Left_I, Right_I, 11, 11);
imshow(disparityMap, [-15 15]);