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
k=40;

corrects = zeros(k,4);

confusionh_e = zeros(8,8,k);
confusionh_c = zeros(8,8,k);
confusionr_e = zeros(8,8,k);
confusionr_c= zeros(8,8,k);

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
    
    for j=1:k
        [~,predh_e_i] = mink(disth_e,j);
        [~,predh_c_i] = mink(disth_c,j);
        [~,predr_e_i] = mink(distr_e,j);
        [~,predr_c_i] = mink(distr_c,j);
        predh_e = mode(trainLables(1,predh_e_i),'all');
        predh_c =mode(trainLables(1,predh_c_i),'all');
        predr_e =mode(trainLables(1,predr_e_i),'all');
        predr_c =mode(trainLables(1,predr_c_i),'all');
        testLabel =test_labels(1,i); 

        if(predh_e== testLabel)
            corrects(j,1) = corrects(j,1)+1;
        end

        if(predh_c== testLabel)
            corrects(j,2) = corrects(j,2)+1;
        end

        if(predr_e== testLabel)
            corrects(j,3) = corrects(j,3)+1;
        end

        if(predr_c== testLabel)
            corrects(j,4) = corrects(j,4)+1;
        end
        confusionh_e(testLabel,predh_e,j)=confusionh_e(testLabel,predh_e,j)+1;
        confusionh_c(testLabel,predh_c,j)=confusionh_c(testLabel,predh_c,j)+1;
        confusionr_e (testLabel,predr_e,j)=confusionr_e(testLabel,predr_e,j)+1;
        confusionr_c(testLabel,predr_c,j)=confusionr_c(testLabel,predr_c,j)+1; 
        
    end      
end
[accuracyh_e,kh_e] =max(corrects(:,1)./test_num);
[accuracyh_c,kh_c] =max(corrects(:,2)./test_num);
[accuracyr_e,kr_e]= max(corrects(:,3)./test_num);
[accuracyr_c,kr_c] = max(corrects(:,4)./test_num);

