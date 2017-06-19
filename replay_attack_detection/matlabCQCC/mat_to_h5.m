clear; close all; clc;


data = load('./files/genuineFeatureCellDev.mat');


for i=1:length(data.genuineFeatureCellDev)
    tmp = data.genuineFeatureCellDev{i};
    h5create('genuineFeatureCellDev.h5', strcat('/DS', int2str(i)), size(tmp));
    h5write ('genuineFeatureCellDev.h5', strcat('/DS', int2str(i)), tmp);
end


data = load('./files/genuineFeatureCellTrain.mat');

for i=1:length(data.genuineFeatureCellTrain)
    tmp = data.genuineFeatureCellTrain{i};
    h5create('genuineFeatureCellTrain.h5', strcat('/DS', int2str(i)), size(tmp));
    h5write ('genuineFeatureCellTrain.h5', strcat('/DS', int2str(i)), tmp);
end


data = load('./files/spoofFeatureCellDev.mat');

for i=1:length(data.spoofFeatureCellDev)
    tmp = data.spoofFeatureCellDev{i};
    h5create('spoofFeatureCellDev.h5', strcat('/DS', int2str(i)), size(tmp));
    h5write ('spoofFeatureCellDev.h5', strcat('/DS', int2str(i)), tmp);
end

data = load('./files/spoofFeatureCellTrain.mat');

for i=1:length(data.spoofFeatureCellTrain)
    tmp = data.spoofFeatureCellTrain{i};
    h5create('spoofFeatureCellTrain.h5', strcat('/DS', int2str(i)), size(tmp));
    h5write ('spoofFeatureCellTrain.h5', strcat('/DS', int2str(i)), tmp);
end

data = load('./files/evaluationFeature.mat');

for i=1:length(data.evaluationFeature)
    tmp = data.evaluationFeature{i};
    h5create('evaluationFeature.h5', strcat('/DS', int2str(i)), size(tmp));
    h5write ('evaluationFeature.h5', strcat('/DS', int2str(i)), tmp);
end



filenames = {'evaluationFeature.mat','spoofFeatureCellTrain.mat', 
            'spoofFeatureCellDev.mat', 'genuineFeatureCellTrain.mat',
            'genuineFeatureCellDev.mat'}