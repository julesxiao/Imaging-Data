close all;
clc;
I = imread('lenaNoise.png');
%2. (a)
I_fft = fft2(I);
I_center = fftshift(I_fft);
figure,imshow(I),title('original image');
%call function fftshow
fftshow(I_center);
%2. (b)(c)
[a,b] = size(I_center);
[i,j] = meshgrid((-(a/2)):(a/2-1),(-(b/2)):(b/2-1)); %-256:255
k = sqrt(i.^2+ j.^2);
%keep low frequencies 10*10
filter = k<10;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
%call function ifftshow
ifftshow(ifft2(Ilow)),title('lowpass: 10*10');
%keep low frequencies 20*20
filter = k<20;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
ifftshow(ifft2(Ilow)),title('lowpass: 20*20');
%keep low frequencies 40*40
filter = k<40;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
ifftshow(ifft2(Ilow)),title('lowpass: 40*40');
%keep low frequencies 100*100
filter = k<100;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
ifftshow(ifft2(Ilow)),title('lowpass: 100*100');
%keep low frequencies 300*300
filter = k<300;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
ifftshow(ifft2(Ilow)),title('lowpass: 300*300');
%full dimension
filter = k<a;
Ilow = I_center.*filter;
fftshow(Ilow),title('Fourier domain');
ifftshow(ifft2(Ilow)),title('lowpass: full dimension');

