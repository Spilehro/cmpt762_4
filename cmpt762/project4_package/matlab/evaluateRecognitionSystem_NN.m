test_imagenames = load('../data/traintest.mat','test_imagenames').test_imagenames;
test_labels = load('../data/traintest.mat','test_labels').test_labels;
test_num = size(test_imagenames,2);
root_dir = '../data/';

dictionaryh = load('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels').dictionary;
filterBankh = load('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels').filterBank;
trainFeaturesh = load('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels').trainFeatures;

dictionaryr = load('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels').dictionary;
filterBankr = load('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels').filterBank;
trainFeaturesr = load('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels').trainFeatures;

trainLables = load('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels').trainLabels;
dictionary_size = size(dictionaryh,1);

confusionh_e = zeros(8,8);
confusionh_c = zeros(8,8);
confusionr_e = zeros(8,8);
confusionr_c= zeros(8,8);

correcth_e=0;
correcth_c=0;
correctr_e=0;
correctr_c=0;

method_e = 'euclidean';
method_c = 'chi2';


for i=1:test_num
    wordMap_name =strcat(root_dir,test_imagenames{1,i});
    
    wordMaph_name=strrep(wordMap_name,'.jpg','_Harris.mat');
    wordMapr_name=strrep(wordMap_name,'.jpg','_Random.mat');
   
    
    wordMaph = load(wordMaph_name,'wordMaph').wordMaph;
    wordMapr = load(wordMapr_name,'wordMapr').wordMapr;
    
    histh = getImageFeatures(wordMaph,dictionary_size);
    histr = getImageFeatures(wordMapr,dictionary_size);
    
    disth_e = getImageDistance(histh,trainFeaturesh,method_e);
    disth_c = getImageDistance(histh,trainFeaturesh,method_c);
    
    distr_e = getImageDistance(histr,trainFeaturesr,method_e);
    distr_c = getImageDistance(histr,trainFeaturesr,method_c);
    
    [~,predh_e_i] = min(disth_e);
    [~,predh_c_i] = min(disth_c);
    [~,predr_e_i] = min(distr_e);
    [~,predr_c_i] = min(distr_c);
    
    predh_e = trainLables(1,predh_e_i);
    predh_c = trainLables(1,predh_c_i);
    predr_e = trainLables(1,predr_e_i);
    predr_c = trainLables(1,predr_c_i);
    
    testLabel =test_labels(1,i); 
    
    if(predh_e== testlabel)
        correcth_e = correcth_e+1;
    end
    
    if(predh_c== testlabel)
        correcth_c = correcth_c+1;
    end
    
    if(predr_e== testlabel)
        correctr_e = correctr_e+1;
    end
    
    if(predr_c== testlabel)
        correctr_c = correctr_c+1;
    end
    
    confusionh_e(testLabel,predh_e)=confusionh_e(testLabel,predh_e)+1;
    confusionh_c(testLabel,predh_c)=confusionh_c(testLabel,predh_c)+1;
    confusionr_e (testLabel,predr_e)=confusionr_e(testLabel,predr_e)+1;
    confusionr_c(testLabel,predr_c)=confusionr_c(testLabel,predr_c)+1;   
end
accuracyh_e = correcth_e/test_num;
accuracyh_c = correcth_c/test_num;
accuracyr_e= correctr_e/test_num;
accuracyr_c = correctr_c/test_num;

