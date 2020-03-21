
function [filterResponses] = extractFilterResponses_sift(I)
   I = rgb2gray(I);
   I = double(I);
   points =detectSURFFeatures(I);
   filterResponses = extractFeatures(I,points);
end