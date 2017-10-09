function [Center , Bounding , radius] = find_ball_new(data) 
 
%     h = [0.3 0.4]; 
%     s = [0.6 1];
%     v = [0.5 1]; 

%     h = [0 0.23]; 
%     s = [0.34 0.9];
%     v = [0.9 1];

    h = [0 20]/255; 
    s = [141 229]/255;
    v = [155 255]/255;

%     h = [0 0.08]; 
%     s = [0.34 0.9];
%     v = [0.9 1];
    
    image = rgb2hsv(data); 
    
%     h1=image(: , : ,1);
%     s1=image(: , : ,2);
%     v1=image(: , : ,3);
%     
%     hMF = medfilt2(h1, [3 3]);
%     sMF = medfilt2(s1, [3 3]);
%     vMF = medfilt2(v1, [3 3]);
%     
%     image = cat(3, hMF, sMF, vMF);
    
%     diffH = (image(:,:,1) - h(2));
%     diffS = (image(:,:,2) - s(2));
%     diffV = (image(:,:,3) - v(2));
%     
%     image = cat(3, diffH, diffS, diffV);

    image = hsv2binary(image,h,s,v); 
    cc = bwconncomp(image); 
    %     HSV = rgb2hsv(current_frame);
   
    
    
    stats = regionprops(cc, 'BoundingBox', 'Centroid','Area');   %   

    if isempty(stats)
        Center = [];
        Bounding = [];
        radius = [];
        return
    end

    Center = stats(1).Centroid';
    Bounding = stats(1).BoundingBox';
    radius = sqrt(stats(1).Area/pi);

    disp(Center)
    %disp(Bounding)
    %disp(radius)

end
