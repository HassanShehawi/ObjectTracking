% Function that converts a color image into a binary 
% image such that the pixels that are in specified 
% color range become 1 and all others become 0 
function output = hsv2binary(input,h,s,v) 
    output = input(:,:,1)>=h(1)&input(:,:,1)<=h(2)&... 
    input(:,:,2)>=s(1)&input(:,:,2)<=s(2)&... 
    input(:,:,3)>=v(1)&input(:,:,3)<=v(2); 
end