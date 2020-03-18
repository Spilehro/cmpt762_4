function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    num_img = size(imgPaths,2);
    filterBank = createFilterBank();
    num_filter = size(filterBank,1);
    pixelResponses = zeros(alpha*num_img,3*num_filter);
    root_dir = '../data/';
 
    for i=1:num_img
        
        img_name = strcat(root_dir,imgPaths{1,i});
        I = imread(img_name);
        [row,col,ch]=size(I);
        filterResponses = extractFilterResponses(I, filterBank);
        if(ch==3)  
            
            [fr fc fch]=size(filterResponses);
            filterResponses = reshape(filterResponses,[fr*fc,fch]);
            
            if(strcmp('Random',method))
                points = getRandomPoints(I,alpha);
            end
            
            if(strcmp('Harris',method))
                k=0.05;
                points = getHarrisPoints(I,alpha,k);
            end
            
           inds = sub2ind([row, col],points(:,2),points(:,1));
           
           starti = (i-1)*alpha+1;
           endi = starti+alpha-1;
           
           pixelResponses(starti:endi,:)=filterResponses(inds,:);
           
        end
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
    dict_name = strcat('dictionary',method,'.mat');
    save(dict_name,'dictionary','filterBank');
end