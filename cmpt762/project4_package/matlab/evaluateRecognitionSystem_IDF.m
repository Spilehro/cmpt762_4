idfh  =load('idf.mat','IDFh').IDFh;
idfr  =load('idf.mat','IDFr').IDFr;

test_imagenames = load('../data/traintest.mat','test_imagenames').test_imagenames;
test_labels = load('../data/traintest.mat','test_labels').test_labels;
test_num = size(test_imagenames,2);
root_dir = '../data/';

trainFeaturesh= load('visionHarris.mat','trainFeatures').trainFeatures;
trainFeaturesr = load('visionRandom.mat','trainFeatures').trainFeatures;

trainLabels=load('visionRandom.mat','trainLabels').trainLabels;

dictionary_size = size(trainFeaturesr,2);

% tl = templateSVM('Standardize',true,'KernelFunction','linear');
% 
% 
% Mdlh_l = fitcecoc(Xh,Y,'Learners',tl,...
%     'ClassNames',1:8);
% 
% Mdlr_l = fitcecoc(Xr,Y,'Learners',tl,...
%     'ClassNames',1:8);
% 
load('visionSVM.mat');

for i=1:test_num
    wordMap_name =strcat(root_dir,test_imagenames{1,i});
    
    wordMaph_name=strrep(wordMap_name,'.jpg','_Harris.mat');
    wordMapr_name=strrep(wordMap_name,'.jpg','_Random.mat');
   
    
    wordMaph = load(wordMaph_name,'wordMaph').wordMaph;
    wordMapr = load(wordMapr_name,'wordMapr').wordMapr;
    
    histh = getImageFeatures(wordMaph,dictionary_size);
    histr = getImageFeatures(wordMapr,dictionary_size);
    
    histh = histh.*idfh;
    histr = histr.*idfr;
    
    predh_l=predict(Mdlh_l,histh);
    predr_l = predict(Mdlr_l,histr);
    
    
    testLabel =test_labels(1,i); 
    
    if(predh_l== testLabel)
        correcth_l = correcth_l+1;
    end
    
    if(predr_l== testLabel)
        correctr_l = correctr_l+1;
    end
    
end

accuracyh_l = correcth_l/test_num;
accuracyr_l = correctr_l/test_num;

disp(strcat('HL ',num2str(accuracyh_l)));
disp(strcat('RL ',num2str(accuracyr_l)));

