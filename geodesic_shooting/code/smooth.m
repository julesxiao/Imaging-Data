function [I_filtered] = smooth(I,fre)
[a,b] = size(I);
[i,j] = meshgrid((-(a/2)):(a/2-1),(-(b/2)):(b/2-1)); 
k = (abs(i) < fre & abs(j) < fre);
%keep low frequencies 16*16
filter = k;
I_filtered = I.*filter;