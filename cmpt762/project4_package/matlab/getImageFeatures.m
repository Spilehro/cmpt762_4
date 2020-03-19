function [ h ] = getImageFeatures(wordMap, dictionarySize)

  [h,~] = histcounts(wordMap,1:dictionarySize+1);
  h = h./norm(h,1);
end