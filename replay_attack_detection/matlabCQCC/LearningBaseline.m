
clear; close all; clc;

% add required libraries to the path
addpath(genpath('utility'));
addpath(genpath('CQCC_v1.0'));
addpath(genpath('bosaris_toolkit'));

% set paths to the wave files and protocols
dir = 'N:\Science\Antispoofing Research (ipython notebook)\asvspoof2017';
pathToDatabase = fullfile(dir,'ASVspoof2017_train_dev','wav');
trainProtocolFile = fullfile(dir,'ASVspoof2017_train_dev', 'protocol', 'ASVspoof2017_train.trn');
devProtocolFile = fullfile(dir,'ASVspoof2017_train_dev', 'protocol', 'ASVspoof2017_dev.trl');

genuineFeatureCellTrain = load('./files/genuineFeatureCellTrain.mat');
genuineFeatureCellDev = load('./files/genuineFeatureCellDev.mat');
spoofFeatureCellDev = load('./files/spoofFeatureCellDev.mat');
spoofFeatureCellTrain = load('./files/spoofFeatureCellTrain.mat');

%% GMM training

% train GMM for GENUINE data
disp('Training GMM for GENUINE...');
[genuineGMM.m, genuineGMM.s, genuineGMM.w] = vl_gmm([genuineFeatureCellTrain.genuineFeatureCellTrain{:}], 512, 'verbose', 'MaxNumIterations',100);
disp('Done!');

% train GMM for SPOOF data
disp('Training GMM for SPOOF...');
[spoofGMM.m, spoofGMM.s, spoofGMM.w] = vl_gmm([spoofFeatureCellTrain.spoofFeatureCellTrain{:}], 512, 'verbose', 'MaxNumIterations',100);
disp('Done!');


%% Feature extraction and scoring of development data

% read development protocol
fileID = fopen(devProtocolFile);
protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);

labels = protocol{2};

genuineFeatureCellDev = load('./files/genuineFeatureCellDev.mat');
spoofFeatureCellDev = load('./files/spoofFeatureCellDev.mat');
all_data = cat(1,genuineFeatureCellDev.genuineFeatureCellDev,spoofFeatureCellDev.spoofFeatureCellDev);
scores = zeros(size(labels));
%%
for i=1:length(all_data)
    llk_genuine = mean(compute_llk(all_data{i},genuineGMM.m,genuineGMM.s,genuineGMM.w));
    llk_spoof = mean(compute_llk(all_data{i},spoofGMM.m,spoofGMM.s,spoofGMM.w));
    scores(i) = llk_genuine - llk_spoof;
end

disp('Done!');

%% compute performance
[Pmiss,Pfa] = rocch(scores(strcmp(labels,'genuine')),scores(strcmp(labels,'spoof')));
EER = rocch2eer(Pmiss,Pfa) * 100; 
fprintf('EER is %.2f\n', EER);

%%%%%%%%%%%%%%%%%%%%%%%% EVALUATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Computing scores for evaluation trials...');
evaProtocolFile = fullfile(dir,'ASVspoof2017_train_dev', 'protocol', 'KEY_ASVspoof2017_eval_V2.trl');

%% Feature extraction and scoring of eva data

% read development protocol
fileID = fopen(evaProtocolFile);

protocol = textscan(fileID, '%s%s%s%s%s%s%s');
filenames = protocol{1};
labels = protocol{2};
fclose(fileID);

disp('Load evaluation set...');
evaluationFeature = load('./files/evaluationFeature.mat');
scores = zeros(size(filenames));
%%
for i=1:length(filenames)
    llk_genuine = mean(compute_llk(evaluationFeature.evaluationFeature{i},genuineGMM.m,genuineGMM.s,genuineGMM.w));
    llk_spoof = mean(compute_llk(evaluationFeature.evaluationFeature{i},spoofGMM.m,spoofGMM.s,spoofGMM.w));
    scores(i) = llk_genuine - llk_spoof;
end
