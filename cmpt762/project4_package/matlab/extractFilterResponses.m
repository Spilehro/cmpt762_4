
function [filterResponses] = extractFilterResponses(I, filterBank)
    num_filters = size(filterBank,1);
    [h w ch] = size(I);
    filterResponses = zeros(h,w,3*num_filters);
    I = double(I);
    
    if(ch==3)   
        R= I(:,:,1);
        G= I(:,:,2);
        B= I(:,:,3);
        
    elseif(ch==1)
        R= I(:,:,1);
        G= I(:,:,1);
        B= I(:,:,1);
        
    end

    [L a b] = RGB2Lab(R,G,B);
    channels = zeros(h,w,3);
    channels (:,:,1)=L;
    channels (:,:,2)=a;
    channels (:,:,3)=b;

    RGB=1;

    for i=1:num_filters*3
        filter =ceil(i/3);
        filterResponses(:,:,i)=conv2(channels(:,:,RGB),filterBank{filter,1},'same');
        RGB=RGB+1;
        if(RGB==4)
            RGB=1;
        end
%         figure;
%         imshow(filterResponses(:,:,i),[]);
    end
end