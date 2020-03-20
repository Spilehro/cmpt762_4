
test_imagenames = load('../data/traintest.mat','test_imagenames').test_imagenames;
test_labels = load('../data/traintest.mat','test_labels').test_labels;
test_num = size(test_imagenames,2);
root_dir = '../data/';

dictionaryh = load('visionHarris.mat','dictionary').dictionary;
trainFeaturesh = load('visionHarris.mat','trainFeatures').trainFeatures;
trainFeaturesr = load('visionRandom.mat','trainFeatures').trainFeatures;

trainLables = load('visionHarris.mat','trainLabels').trainLabels;
dictionary_size = size(dictionaryh,1);




confusionh_l = zeros(8,8);
confusionr_l = zeros(8,8);
confusionh_p = zeros(8,8);
confusionr_p = zeros(8,8);

correcth_l=0;
correctr_l=0;
correcth_p=0;
correctr_p=0;

% Xh = trainFeaturesh;
% Xr = trainFeaturesr;
% Y = trainLables;
% 
% 
% tl = templateSVM('Standardize',true,'KernelFunction','linear');
% tp = templateSVM('Standardize',true,'KernelFunction','polynomial');
% 
% Mdlh_l = fitcecoc(Xh,Y,'Learners',tl,...
%     'ClassNames',1:8);
% 
% Mdlr_l = fitcecoc(Xr,Y,'Learners',tl,...
%     'ClassNames',1:8);
% 
% Mdlh_p = fitcecoc(Xh,Y,'Learners',tp,...
%     'ClassNames',1:8);
% 
% Mdlr_p = fitcecoc(Xr,Y,'Learners',tp,...
%     'ClassNames',1:8);
load('visionSVM.mat');

for i=1:test_num
    wordMap_name =strcat(root_dir,test_imagenames{1,i});
    
    wordMaph_name=strrep(wordMap_name,'.jpg','_Harris.mat');
    wordMapr_name=strrep(wordMap_name,'.jpg','_Random.mat');
   
    
    wordMaph = load(wordMaph_name,'wordMaph').wordMaph;
    wordMapr = load(wordMapr_name,'wordMapr').wordMapr;
    
    histh = getImageFeatures(wordMaph,dictionary_size);
    histr = getImageFeatures(wordMapr,dictionary_size);
    
    predh_l=predict(Mdlh_l,histh);
    predr_l = predict(Mdlr_l,histr);
    
    predh_p=predict(Mdlh_p,histh);
    predr_p = predict(Mdlr_p,histr);
    
    
    testLabel =test_labels(1,i); 
    
    if(predh_l== testLabel)
        correcth_l = correcth_l+1;
    end
    
    if(predr_l== testLabel)
        correctr_l = correctr_l+1;
    end
    
    if(predh_p== testLabel)
        correcth_p = correcth_p+1;
    end
    
    if(predr_p== testLabel)
        correctr_p = correctr_p+1;
    end
     
    
    confusionh_l(testLabel,predh_l)=confusionh_l(testLabel,predh_l)+1;
    confusionr_l (testLabel,predr_l)=confusionr_l(testLabel,predr_l)+1;
    confusionh_p(testLabel,predh_l)=confusionh_p(testLabel,predh_p)+1;
    confusionr_p (testLabel,predr_l)=confusionr_p(testLabel,predr_p)+1;
end

accuracyh_l = correcth_l/test_num;
accuracyr_l = correctr_l/test_num;
accuracyh_p = correcth_p/test_num;
accuracyr_p = correctr_p/test_num;

fprintf('SVM_accuracyh_l: %f \n',accuracyh_l*100);
fprintf('SVM_accuracyr_l: %f \n',accuracyr_l*100);
fprintf('SVM_accuracyh_p: %f \n',accuracyh_p*100);
fprintf('SVM_accuracyr_p: %f \n',accuracyr_p*100);

%save('visionSVM.mat','Mdlh_l','Mdlr_l','Mdlh_p','Mdlr_p');































