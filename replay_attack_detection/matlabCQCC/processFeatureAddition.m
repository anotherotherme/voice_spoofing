clear; close all; clc;

dir = './';

genuineFeatureCellDev = addNewFeature(dir,'genuineFeatureCellDev','snrOriginalDEV', 'excessOriginalDEV','sigmaOriginalDEV' );
save ('./cqcc_and_3feature/genuineFeatureCellDev.mat', 'genuineFeatureCellDev','-v7.3');

genuineFeatureCellTrain = addNewFeature(dir,'genuineFeatureCellTrain','snrOriginalTRAIN', 'excessOriginalTRAIN','sigmaOriginalTRAIN' );
save ('./cqcc_and_3feature/genuineFeatureCellTrain.mat', 'genuineFeatureCellTrain','-v7.3');

spoofFeatureCellDev = addNewFeature(dir,'spoofFeatureCellDev','snrSpoofDEV', 'excessSpoofDEV','sigmaSpoofDEV' );
save ('./cqcc_and_3feature/spoofFeatureCellDev.mat', 'spoofFeatureCellDev','-v7.3');

spoofFeatureCellTrain = addNewFeature(dir,'spoofFeatureCellTrain','snrSpoofTRAIN', 'excessSpoofTRAIN','sigmaSpoofTRAIN' );
save ('./cqcc_and_3feature/spoofFeatureCellTrain.mat', 'spoofFeatureCellTrain','-v7.3');


evaluationFeature = addNewFeature(dir,'evaluationFeature','snrEVA', 'excessEVA','sigmaEVA' );
save ('./cqcc_and_3feature/evaluationFeature.mat', 'evaluationFeature','-v7.3');