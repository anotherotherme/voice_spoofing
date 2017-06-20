function [frame] = addNewFeature(dir, dataFrame, Feature1,Feature2,Feature3 )
    
    % make fullname
    data_name = strcat(dir,'/files/',dataFrame,'.mat');
    feature_1_name = strcat(dir,'additionFeatures/', Feature1, '.txt');
    feature_2_name = strcat(dir,'additionFeatures/', Feature2, '.txt');
    feature_3_name = strcat(dir,'additionFeatures/', Feature3, '.txt');
 
    % load data
    data = load(data_name);
    feature_1 = load(feature_1_name);
    feature_2 = load(feature_2_name);
    feature_3 = load(feature_3_name);
    
    allAdditionData = [feature_1,feature_2,feature_3];
    
    if strcmp(dataFrame,'genuineFeatureCellDev')
        frame = data.genuineFeatureCellDev;
    elseif strcmp(dataFrame,'genuineFeatureCellTrain')
        frame = data.genuineFeatureCellTrain;
    elseif strcmp(dataFrame,'spoofFeatureCellTrain')
        frame = data.spoofFeatureCellTrain;        
    elseif strcmp(dataFrame,'spoofFeatureCellDev')
        frame = data.spoofFeatureCellDev;
    elseif strcmp(dataFrame,'evaluationFeature')
        frame = data.spoofFeatureCellDev;    
    end
    
    
    for i=1:length(frame)        
        [row, col] = size(frame{i});

        additionArray = zeros(3, col);
        additionArray(1,:) = allAdditionData(i,1);
        additionArray(2,:) = allAdditionData(i,2);
        additionArray(3,:) = allAdditionData(i,3);

        cellToList = [frame{i}];
        frame{i}=[cellToList;additionArray];
    end
end


