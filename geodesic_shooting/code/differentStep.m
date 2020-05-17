%https://www.mathworks.com/matlabcentral/answers/278300-matlab-code-help-on-euler-s-method
function [t,y] = differentStep(h)
t = 0:h:5;
y = zeros(size(t));
% Initialization for y(0)
y(1)= 1; 
n = numel(y);
for i = 1 : n-1
    t(i+1) = t(i)+h; 
    y(i+1) = y(i) + h * f(t(i), y(i));
end



