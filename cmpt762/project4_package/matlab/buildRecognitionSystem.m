function buildRecognitionSystem()
dictionaryHarris = load('dictionaryHarris.mat','dictionary','filterBank').dictionary;
filterBankHarris = load('dictionaryHarris.mat','dictionary','filterBank').filterBank; 

dictionaryRandom = load('dictionaryRandom.mat','dictionary','filterBank').dictionary;
filterBankRandom = load('dictionaryRandom.mat','dictionary','filterBank').filterBank;

trainLabels = load('../data/traintest.mat','train_labels').train_labels;

train_imagenames = load('../data/traintest.mat','train_imagenames').train_imagenames;

num_img = size(train_imagenames,2);
dictionary_size = size(dictionaryHarris,1);
trainFeaturesHarris= zeros(num_img,dictionary_size);
trainFeaturesRandom= zeros(num_img,dictionary_size);
root_dir = '../data/';

tic;
pool =parpool;
parfor i=1:num_img
    image_name = strcat(root_dir,train_imagenames{1,i});
    I = imread(image_name);
    
    wordMapHarris =  getVisualWords(I, filterBankHarris, dictionaryHarris);
    wordMapRandom =  getVisualWords(I, filterBankRandom, dictionaryRandom);
    
    trainFeaturesHarris(i,:)=getImageFeatures(wordMapHarris, dictionary_size);
    trainFeaturesRandom(i,:)=getImageFeatures(wordMapRandom, dictionary_size);
end
delete(pool);

dictionary = dictionaryHarris;
filterBank = filterBankHarris;
trainFeatures = trainFeaturesHarris;

save('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels');

dictionary = dictionaryRandom;
filterBank = filterBankRandom;
trainFeatures = trainFeaturesRandom;

save('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels');
toc;
end


