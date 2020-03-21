location ='../data/';
imds = imageDatastore(location,'FileExtensions',{'.jpg'},'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
[trainingSet,testSet] = splitEachLabel(imds,0.3,'randomize');
bag = bagOfFeatures(imds);
