%https://www.mathworks.com/matlabcentral/answers/165262-how-can-i-get-the-divergence-of-vector-field-of-a-gray-scale-image
function D = div(I)
[X Y] = meshgrid(1:size(I, 2), 1:size(I, 1));
D = divergence(X, Y, Dx(I), Dy(I));
return