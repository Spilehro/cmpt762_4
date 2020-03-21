idfh  =load('idf.mat','IDFh').IDFh;
idfr  =load('idf.mat','IDFr').IDFr;

test_imagenames = load('../data/traintest.mat','test_imagenames').test_imagenames;
test_labels = load('../data/traintest.mat','test_labels').test_labels;
test_num = size(test_imagenames,2);
root_dir = '../data/';

trainFeaturesh= load('visionHarris.mat','trainFeatures').trainFeatures;
trainFeaturesr = load('visionRandom.mat','trainFeatures').trainFeatures;

dictionary_size = size(trainFeaturesr,2);
trainimg_num = size(trainFeaturesr,1);

trainFeaturesh = trainFeaturesh.*repmat(idfh, [trainimg_num,1]);
trainFeaturesr = trainFeaturesr.*repmat(idfr, [trainimg_num,1]);


trainLables=load('visionRandom.mat','trainLabels').trainLabels;



confusionh_l = zeros(8,8);
confusionr_l = zeros(8,8);

correcth_l=0;
correctr_l=0;
% 
Xh = trainFeaturesh;
Xr = trainFeaturesr;
Y = trainLables;


tl = templateSVM('Standardize',true,'KernelFunction','linear');

Mdlh_l = fitcecoc(Xh,Y,'Learners',tl,...
    'ClassNames',1:8);

Mdlr_l = fitcecoc(Xr,Y,'Learners',tl,...
    'ClassNames',1:8);

%load('visionSVM_IDF.mat');
fprintf('SVM_IDF Started! \n');


for i=1:test_num
    wordMap_name =strcat(root_dir,test_imagenames{1,i});
    
    wordMaph_name=strrep(wordMap_name,'.jpg','_Harris.mat');
    wordMapr_name=strrep(wordMap_name,'.jpg','_Random.mat');
   
    
    wordMaph = load(wordMaph_name,'wordMaph').wordMaph;
    wordMapr = load(wordMapr_name,'wordMapr').wordMapr;
    
    histh = getImageFeatures(wordMaph,dictionary_size).*idfh;
    histr = getImageFeatures(wordMapr,dictionary_size).*idfr;
    
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

fprintf('SVM_accuracyh_l: %f \n',accuracyh_l*100);
fprintf('SVM_accuracyr_l: %f \n',accuracyr_l*100);


save('visionSVM_IDF.mat','Mdlh_l','Mdlr_l');































