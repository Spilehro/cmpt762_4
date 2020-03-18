function [points] = getRandomPoints(I, alpha)
 [row col ch] = size(I);
 ind = randi(row*col,1,alpha);
 [rowp colp]=ind2sub([row col],ind);
 points=[colp' rowp'];
end