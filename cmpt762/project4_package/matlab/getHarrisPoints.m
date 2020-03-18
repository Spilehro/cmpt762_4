function [points] = getHarrisPoints(I, alpha, k)
   [row col ch] = size(I);
   window_size = 3;
   kernel = ones(window_size);
   
   if(ch==3)
       I=rgb2gray(I);
   end
   
   [Ix Iy] = imgradientxy(I);
   
   
   Ixx = imgaussfilt(Ix.*Ix,1);
   Ixy = imgaussfilt(Ix.*Iy,1);
   Iyy = imgaussfilt(Iy.*Iy,1);
   
   m11 = conv2(Ixx,kernel,'same');
   m12 = conv2(Ixy,kernel,'same');
   m22 = conv2(Iyy, kernel, 'same');
   
   R = (m11.*m22-m12.*m12)-k*((m11+m22).^2);
   [row col] =size(R);
   highest_response = imregionalmax(R);
   R= R.*highest_response;
      
   [~,ind] = sort(R(:),1,'descend');
   
   highest_ind = ind(1:alpha);
   [rowh colh] = ind2sub([row col],highest_ind);
   points=[colh rowh];
      
end