clear all
close all

%% getting the training set and the test set
T = readtable('iris.csv');
C = table2cell(T);

%traning data for versicolor
for i = 51:80
    trainVer(i-50,1) = C{i,1};
    trainVer(i-50,2) = C{i,2};
    trainVer(i-50,3) = C{i,3};
    trainVer(i-50,4) = C{i,4};
end
y1 = zeros(30,1);

%test data for versicolor
for i = 81:100
    testVer(i-80,1) = C{i,1};
    testVer(i-80,2) = C{i,2};
    testVer(i-80,3) = C{i,3};
    testVer(i-80,4) = C{i,4};
end
y2 = zeros(20,1);

%traning data for virginica
for i = 101:130
    trainVirg(i-100,1) = C{i,1};
    trainVirg(i-100,2) = C{i,2};
    trainVirg(i-100,3) = C{i,3};
    trainVirg(i-100,4) = C{i,4};
end
y3 = ones(30,1);

%test data for virginica
for i = 131:150
    testVirg(i-130,1) = C{i,1};
    testVirg(i-130,2) = C{i,2};
    testVirg(i-130,3) = C{i,3};
    testVirg(i-130,4) = C{i,4};
end
y4 = ones(20,1);

% training data for all, concatenate according to column
% rows 1 - 30 are versicolor, 31 - 60 rows are virginica
training1 = cat(1,trainVer,trainVirg);
% add one column of 1's to X, training: 60*5
xTraining = cat(2,training1,ones(60,1));
ytrain = cat(1,y1,y3);

% test data for all
% rows 1 - 20 are versicolor, 21 - 40 are virginica
test1 = cat(1,testVer,testVirg);
% add one column of 1's to X, test: 40*5
xTest = cat(2,test1,ones(40,1));
ytest = cat(1,y2,y4);

%% Gradient of U
iter = 10000;
alpha = 0.0006;
beta = zeros(5,1);

sigma = 3;
graph_eval_U = zeros([1,iter]);
for i= 1:iter
    % Get U
    sum2 = 0;
    for k = 1:60
        xiT = xTraining(k,:);
        %each = (1 - ytrain(k,1) - exp(- xiT*beta)/(1 + exp(- xiT*beta)))* transpose(xiT);
        each = (1 - ytrain(k,1))* xiT*beta + log(1+exp(- xiT*beta));
        sum2 = sum2 + each;
    end
    U = sum2 + 1/(2*square(sigma))*transpose(beta)*beta;
    
    % Gradient term: derivative of U over beta
    sum = 0;
    for j = 1:60
        xiT = xTraining(j,:);
        each = (1 - ytrain(j,1) - exp(- xiT*beta)/(1 + exp(- xiT*beta)))* transpose(xiT);
        sum = sum + each;
    end
    deriU = sum + 1/square(sigma) * beta;
    beta_next = beta - alpha * deriU;
    beta = beta_next;
    graph_eval_U(i) = U;
end 

x = 1:iter;
figure(1),plot(x, graph_eval_U(x)),title('U');

for i= 1: 40
    ytemp(i,1) = 1/(1+exp(- xTest(i,:)*beta));
    if(ytemp(i,1) < 0.5)
        yresult(i,1) = 0;
    else
        yresult(i,1) = 1;
    end
end

error = yresult - ytest;
fprintf('Average error rate: %4.2f \n ',norm(error,1)/40);







