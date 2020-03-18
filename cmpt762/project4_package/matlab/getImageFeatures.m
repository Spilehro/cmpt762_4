function [ h ] = getImageFeatures(wordMap, dictionarySize)

  [h,~] = histcounts(wordMap,dictionarySize);
  h = h./norm(h,1);
end