function b = dementionReduction(a)
siz = size(a);
siz(siz==1) = []; % Remove singleton dimensions. //?1 ??.....
siz = [siz ones(1,2-length(siz))]; % Make sure siz is at least 2-D
b = reshape(a,siz);