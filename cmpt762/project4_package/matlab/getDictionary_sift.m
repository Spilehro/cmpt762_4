function [dictionary] = getDictionary_sift(imgPaths, alpha, K)
    num_img = size(imgPaths,2);
    
    pixelResponses = zeros(alpha*num_img,64);
    root_dir = '../data/';
 
    for i=1:num_img
        
       img_name = strcat(root_dir,imgPaths{1,i});
       I = imread(img_name);
       [row,col,ch]=size(I);
       filterResponses = extractFilterResponses_sift(I);
       num_features = min(alpha,size(filterResponses,1));
        
       starti = (i-1)*alpha+1;
       endi = starti+alpha-1;

       pixelResponses(starti:num_features,:)=filterResponses(1:num_features,:);
       if(num_eatures<alpha)
          pixelResponses(num_features+1:endi,:)=reptmat(filterResponses(num_features,:),[endi-num_features,1]);
       end          
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop','MaxIter',1000);
    dict_name = strcat('dictionary',method,'.mat');
    save(dict_name,'dictionary');
end