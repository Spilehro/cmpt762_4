function [dist] = getImageDistance(hist1, histSet, method)

  if (strcmp(method,'euclidean'))
    dist = pdist2(hist1,histSet,'euclidean');
    
  elseif (strcmp(method,'chi2'))
      
    sub = (hist1-histSet).^2;
    sumi = hist1+histSet;
    div = sub./sumi;
    sum_end =sum(div,2);
    dist = sum_end./2;
    dist(isnan(dist))=0;
          
  end

end