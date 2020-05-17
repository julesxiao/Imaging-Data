clear;
clc;
%read in initial velocity
vt_ori = loadMETA('./v0Spatial.mhd');
% remove the last components of Vt in each direction since they're zero
vt = vt_ori;
vt(3:3,:,:) = [];
%read in the source image
img_ori = loadMETA('./source.mhd');
figure;
imshow(img_ori);
title('original image');
%the initial transformation phi0
[phi0_x, phi0_y] = meshgrid(1:100,1:100);
phi0(1, :, :) = phi0_x;
phi0(2, :, :) = phi0_y;
%% Euler integration to get Va and Vb, where i implement f_a and f_b for the euler method
h = 0.01;
t = 0:h:1;
v_a = cell(size(t));
v_b = cell(size(t));
% Initialization for v0
v_a{1,1}= vt; 
v_b{1,1}= vt; 
[a,size_t] = size(t);
for i = 1 : (size_t-1)
    v_a{1,i+1} = v_a{1,i} + h * f_a(v_a{1,i});
    v_b{1,i+1} = v_b{1,i} + h * f_b(v_b{1,i});
end
%% get phi1 for a (and b),where I implement fphi_a and fphi_b for the euler method
phi_a = cell(size(t));
phi_b = cell(size(t));
phi_a{1,1}= phi0; 
phi_b{1,1}= phi0;
phit_x = phi_a{1,1}(1, :, :);
for i = 1 : (size_t-1)
    phi_a{1,i+1} = phi_a{1,i} + h * fphi_a(v_a{1,i}, phi_a{1,i});
end
phi1_a= phi_a{1,size_t};
%% get phi1 for b
for i = 1 : (size_t-1)
    phi_b{1,i+1} = phi_b{1,i} + h * fphi_b(v_b{1,i}, phi_b{1,i});
end
phi1_b= phi_b{1,size_t};
%% test on the original image
phi1a_x = phi1_a(1, :, :);
phi1a_x = dementionReduction(phi1a_x);% dementionReduction is used to reduce dimentions
phi1a_y = phi1_a(2, :, :);
phi1a_y = dementionReduction(phi1a_y);
img_inta = interp2(img_ori,phi1a_x,phi1a_y,'spline');
figure;
imshow(img_inta);title('interp a');

phi1b_x = phi1_b(1, :, :);
phi1b_x = dementionReduction(phi1b_x);
phi1b_y = phi1_b(2, :, :);
phi1b_y = dementionReduction(phi1b_y);
img_inta = interp2(img_ori,phi1b_x,phi1b_y,'spline');
figure;
imshow(img_inta);title('interp b');
%% compare phi1_a and phi1_b
phi1_error = phi1_b - phi1_a;
compare_phix = phi1_error(1,:,:);
compare_phiy = phi1_error(2,:,:);
figure;
imshow(dementionReduction(compare_phix));title('error of b-a in x direction');
figure;
imshow(dementionReduction(compare_phiy));title('error of b-a in y direction');




