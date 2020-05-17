clear all
close all
%% read in all points
allFiles = dir('dat/107*.pts');
cPts = cell(length(allFiles));
for iI=1:length(allFiles)
    cPts{1,iI} = readPoints( strcat('dat/',allFiles(iI).name ) );  
end
numOfPoints = length(allFiles)


%% Processing
%1) Compute mean
%% iteration part
iter = 2;
graph_eval_E = zeros([1,iter]);
%1) set the mean to the first point set, x(mu) = x(1)
xmu = cPts{1,1};
for i = 1:iter
    %2)align all x(i) to x(mu), only use ptsA
    for iI=1:length(allFiles)
        [ptsA,pars] = getAlignedPts(xmu,cPts{1,iI});
        ptsASet{1,iI} = ptsA;
    end
    % Vertically concatenate A and B.
    % C = vertcat(A,B)
    xmuAligned = vertcat(xmu(:,1),xmu(:,2));
    E = 0;
    for iI=1:length(allFiles)
        ptsASetAlignedEach = vertcat(ptsASet{1,iI}(:,1),ptsASet{1,iI}(:,2));
        E = E + (xmuAligned - ptsASetAlignedEach)'*(xmuAligned - ptsASetAlignedEach);
    end
    graph_eval_E(i) = E;
    %3) calculate the new mean :x(mu) = 1/N sum(x^(i))
    sum = ptsASet{1,1};
    for iI=2:length(allFiles)
        sum = sum + ptsASet{1,iI};
    end
    xmu =  1/21 * sum;
    %4) Align x(mu) to x(1) and update xmu
    [ptsANew,parsNew] = getAlignedPts(cPts{1,1},xmu);
    xmu = ptsANew;
end
xmu = (vertcat(xmu(:,1),xmu(:,2)))';
%get the aligned X (21,136)
for i=1:numOfPoints
    X(i,:) = vertcat(ptsASet{1,i}(:,1),ptsASet{1,i}(:,2));
end
%2) Replace  x(i) <- x(i) - x(mu), get Y (21,136)
for iI=1:numOfPoints
    Y(iI,:) = X(iI,:) - xmu;
end
%get the Covariance Matrix A (136,136)
A = Y'* Y;
%get eigen values and eigen vectors
%[U,S,V] = svd(A);
[U,S] = eig(A);
% the three most important shape variations
% the first column, shape1 (136,1)
shape1 = U(:,136);
count = 0;
for sigma = -2 : 1 : 2
    count = count + 1;
    reconstruted{1,count} = sigma * Y(1,:) * shape1 * shape1' + xmu ;
end
for i= 1: count
    eachpts = reconstruted{1,i};
    eachpts = eachpts';
    eachpts2column{1,i} = [eachpts(1:68,:),eachpts(69:136,:)];
end

figure(1)
drawFaceParts( -eachpts2column{1,1}, 'k-');
figure(2)
drawFaceParts( -eachpts2column{1,2}, 'b-*');
figure(3)
drawFaceParts( -eachpts2column{1,3}, 'g-*');
figure(4)
drawFaceParts( -eachpts2column{1,4}, 'r-*');
figure(5)
drawFaceParts( -eachpts2column{1,5}, 'k-*');
% shape2 = U(:,2);
shape2 = U(:,135);
count = 0;
for sigma = -2 : 1 : 2
    count = count + 1;
    reconstruted{1,count} = sigma * Y(1,:) * shape2 * shape2' + xmu ;
end
for i= 1: count
    eachpts = reconstruted{1,i};
    eachpts = eachpts';
    eachpts2column2{1,i} = [eachpts(1:68,:),eachpts(69:136,:)];
end
figure(6)
drawFaceParts( -eachpts2column2{1,1}, 'k-');
figure(7)
drawFaceParts( -eachpts2column2{1,2}, 'b-*');
figure(8)
drawFaceParts( -eachpts2column2{1,3}, 'g-*');
figure(9)
drawFaceParts( -eachpts2column2{1,4}, 'r-*');
figure(10)
drawFaceParts( -eachpts2column2{1,5}, 'k-*');
% shape3 = U(:,3);
shape3 = U(:,134);
count = 0;
for sigma = -2 : 1 : 2
    count = count + 1;
    reconstruted{1,count} = sigma * Y(1,:) * shape3 * shape3' + xmu ;
end
for i= 1: count
    eachpts = reconstruted{1,i};
    eachpts = eachpts';
    eachpts2column3{1,i} = [eachpts(1:68,:),eachpts(69:136,:)];
end
figure(11)
drawFaceParts( -eachpts2column3{1,1}, 'k-');
figure(12)
drawFaceParts( -eachpts2column3{1,2}, 'b-*');
figure(13)
drawFaceParts( -eachpts2column3{1,3}, 'g-*');
figure(14)
drawFaceParts( -eachpts2column3{1,4}, 'r-*');
figure(15)
drawFaceParts( -eachpts2column3{1,5}, 'k-*');

% Eigenvalue decay curve after PCA is performed
graph_eval_eigen = zeros([1,136]);
diagS = diag(S);
sumofvalues = 0;
for i = 1:136
    sumofvalues = sumofvalues + diagS(136 - i+1);
end
for i = 1:136
    graph_eval_eigen(i) = SumofEigen(i,diagS)/sumofvalues;
end
x = 1:136;
figure(16)
plot(x, graph_eval_eigen(x)),title('Eigenvalue decay');





