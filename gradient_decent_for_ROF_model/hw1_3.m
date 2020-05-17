close all; clc;
Image_ori = imread('cameraman.tif');
I_noise = imnoise(Image_ori,'gaussian', 0, 0.1);
I = im2double(I_noise);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gradient decent algorithm
%Initialization
[x,y] = size(I);
u = zeros(x);
alpha = 0.06;
lambda = 5;
iter = 1000;
%Initialization of convergence graphs
graph_eval_E = zeros([1,iter]);
graph_eval_g = zeros([1,iter]);
% gradient decent algorithm
for k = 1: iter
    % Energy function
    E =  lambda * norm((I - u), 'fro') +  sqrt(norm(cat(1,Dx(u),Dy(u)),'fro'));%a scalar
    % Gradient term: derivative of E over u, use function div
    deri_E_u = -2 * lambda * (I - u) - div(u) ./ (sqrt(Dx(u).^2 + Dy(u).^2) + eps);%a matrix
    u_next = u - alpha * deri_E_u;
    u = u_next;
    graph_eval_E(k) = E;
    graph_eval_g(k) = norm(deri_E_u,'fro');
end
%plot energy function
x = 1:iter;
figure(1),plot(x, graph_eval_E(x)),title('energy function');
%plot gradient term
x = 1:iter;
figure(2),plot(x, graph_eval_g(x)),title('gradient term');
%show images
figure(3),imshow(Image_ori),title('original image');
figure(4),imshow(I_noise),title('image with Gaussian Noise');
figure(5),imshow(u),title('reconstructed image');


