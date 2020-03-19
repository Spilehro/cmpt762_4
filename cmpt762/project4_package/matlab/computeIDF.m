
trainFeaturesh = load('visionHarris.mat''trainFeatures').trainFeatures;
trainFeaturesr = load('visionRandom.mat','trainFeatures').trainFeatures;

[num_imgs,~] = size(trainFeatures);
dh=sum(trainFeaturesh,1);
IDFh=log(num_imgs./dh);
dr=sum(trainFeaturesr,1);
IDFr=log(num_imgs./dr);

save('idf.mat','IDFh','IDFr');