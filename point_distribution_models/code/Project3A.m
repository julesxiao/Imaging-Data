clear all
close all

%% read in all points
allFiles = dir('dat/107*.pts');
cPts = cell(length(allFiles));
for iI=1:length(allFiles)
    cPts{1,iI} = readPoints( strcat('dat/',allFiles(iI).name ) );  
end
%% iteration part
iter = 10;
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
%% plot
x = 1:iter;
% figure(1)
% plot(x, graph_eval_E(x)),title('Energy Function');
% figure(2)
% for iI=1:length(allFiles)
% facepts = readPoints( strcat('dat/',allFiles(iI).name ) );
% drawFaceParts( -facepts, 'k-' );
% end
% axis off
% axis equal
figure()
drawFaceParts( -xmu, 'r-*');
axis off
axis equal


