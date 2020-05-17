clear all
close all
%% read in all points
allFiles = dir('dat/107*.pts');
cPts = cell(length(allFiles));
len = length(allFiles);
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
        ptsASetAlignedEach{1,iI} = vertcat(ptsASet{1,iI}(:,1),ptsASet{1,iI}(:,2));
    end
    %3) calculate the new mean :x(mu) = 1/N sum(x^(i))
    
    %4) Align x(mu) to x(1) and update xmu
end
% 136*21
for i = 1: len
    ptsASetAligned(:,i) = ptsASetAlignedEach{1,i};
end

%% autoencoder part
% full size
hiddenSize1 = 136;
% 1%
hiddenSize2 = 1;
% 3%
hiddenSize3 = 4;
% 10%
hiddenSize4 = 14;
% full size
autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1);
XReconstructed1 = predict(autoenc,ptsASetAligned);
%% Reconstruction error for full size
mseError1 = mse(ptsASetAligned-XReconstructed1);
% 1%
autoenc = trainAutoencoder(ptsASetAligned,hiddenSize2);
XReconstructed2 = predict(autoenc,ptsASetAligned);
%% Reconstruction error for 1%
mseError2 = mse(ptsASetAligned-XReconstructed2);
% 3%
autoenc = trainAutoencoder(ptsASetAligned,hiddenSize3);
XReconstructed3 = predict(autoenc,ptsASetAligned);
%% Reconstruction error for 3%
mseError3 = mse(ptsASetAligned-XReconstructed3);
% 10%
autoenc = trainAutoencoder(ptsASetAligned,hiddenSize4);
XReconstructed4 = predict(autoenc,ptsASetAligned);
%% Reconstruction error for 10%
mseError4 = mse(ptsASetAligned-XReconstructed4);

fprintf('Reconstruction error(full size): %6.4f \n ',mseError1);
fprintf('Reconstruction error(1 percent): %6.4f \n ',mseError2);
fprintf('Reconstruction error(3 percent): %6.4f \n ',mseError3);
fprintf('Reconstruction error(10 percent): %6.4f \n ',mseError4);
 
%% plot
%% 1)
figure(1)
for i=1:len
    ori = ptsASet{1,i};
    facepts = [XReconstructed1(1:68,i),XReconstructed1(69:136,i)];
    drawFaceParts( -ori, 'r-*');
    drawFaceParts( -facepts, 'g--'); 
end
axis off
axis equal

%% 2)
figure(2)
for i=1:len
    ori = ptsASet{1,i};
    facepts = [XReconstructed2(1:68,i),XReconstructed2(69:136,i)];
    drawFaceParts( -ori, 'r-*');
    drawFaceParts( -facepts, 'g--');
end
axis off
axis equal

figure(3)
for i=1:len
    ori = ptsASet{1,i};
    facepts = [XReconstructed3(1:68,i),XReconstructed3(69:136,i)];
    drawFaceParts( -ori, 'r-*');
    drawFaceParts( -facepts, 'g--');
end
axis off
axis equal

figure(4)
for i=1:len
    ori = ptsASet{1,i};
    facepts = [XReconstructed4(1:68,i),XReconstructed4(69:136,i)];
    drawFaceParts( -ori, 'r-*');
    drawFaceParts( -facepts, 'g--');
end
axis off
axis equal

%% 3)
autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1,'L2WeightRegularization',0.1);
XReconstructed5 = predict(autoenc,ptsASetAligned);
mseError5 = mse(ptsASetAligned-XReconstructed5);
mseError(1) = mseError5;

autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1,'L2WeightRegularization',0.2);
XReconstructed6 = predict(autoenc,ptsASetAligned);
mseError6 = mse(ptsASetAligned-XReconstructed6);
mseError(2) = mseError6;

autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1,'L2WeightRegularization',0.3);
XReconstructed7 = predict(autoenc,ptsASetAligned);
mseError7 = mse(ptsASetAligned-XReconstructed7);
mseError(3) = mseError7;

autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1,'L2WeightRegularization',0.4);
XReconstructed8 = predict(autoenc,ptsASetAligned);
mseError8 = mse(ptsASetAligned-XReconstructed8);
mseError(4) = mseError8;

autoenc = trainAutoencoder(ptsASetAligned,hiddenSize1,'L2WeightRegularization',0.5);
XReconstructed9 = predict(autoenc,ptsASetAligned);
mseError9 = mse(ptsASetAligned-XReconstructed9);
mseError(5) = mseError9;

fprintf('Reconstruction error(weight 0.1): %6.4f \n ',mseError5);
fprintf('Reconstruction error(weight 0.2): %6.4f \n ',mseError6);
fprintf('Reconstruction error(weight 0.3): %6.4f \n ',mseError7);
fprintf('Reconstruction error(weight 0.4): %6.4f \n ',mseError8);
fprintf('Reconstruction error(weight 0.5): %6.4f \n ',mseError9);

% plot
x = 1:5;
xw = 0.1:0.1:0.5;
figure(5)
plot(xw, mseError(x));












