function [wordMap] = getVisualWords(I, filterBank, dictionary)
    filterResponses = extractFilterResponses(I, filterBank);
    [fr fc fch] =size(filterResponses);
    filterResponses = reshape(filterResponses,[fr*fc fch]);
    wordMaps =reshape( pdist2(filterResponses,dictionary,'euclidean'),[fr fc size(dictionary,1)]);
    [~,wordMap] = uint8(min(wordMaps,[],3));
end