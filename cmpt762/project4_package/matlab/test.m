close all;
clear all;
 imgPath = load('../data/traintest.mat','train_imagenames').train_imagenames;
% filterBank = createFilterBank();
  alpha = 200;
%  k=0.05;
 K=200;
 method='Random';
 method2='Harris';
  tic;
  getDictionary_sift(imgPath, alpha, K);
  toc;
root_data = '../data/';
image_name = strcat(root_data,imgPath{1,2});
 I = imread(image_name);
 points = detectSURFFeatures(rgb2gray(I));
 featues= extractFeatures (rgb2gray(I),points);
% alpha=200;
% k=0.05;
% points = getHarrisPoints(I,alpha,k);
% % filterResponses = extractFilterResponses(I, filterBank);
% figure;
% imshow(I);
% hold on
% plot(points(:,1),points(:,2),'r.','MarkerSize',10);
%  I = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
%  dictionary = load('dictionaryHarris.mat','dictionary','filterBank').dictionary;
%  filterBank = load('dictionaryHarris.mat','dictionary','filterBank').filterBank;
%  getVisualWords(I, filterBank, dictionary);
% disp('\nstarted_batch\n');
 tic;
 batchToVisualWords2();
 toc;
buildRecognitionSystem();

%  wordMap = getVisualWords(I,filterBank,dictionary);
% % % figure;
% % % imshow(label2rgb(uint8(wordMap)));
% [ h ] = getImageFeatures(wordMap, size(dictionary,1));
% trainFeatures=load('visionHarris.mat','trainFeatures').trainFeatures;
% getImageDistance(trainFeatures(1,:), trainFeatures, 'chi2');


