clc
clear all

%Initiating the camera
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
triggerconfig(vid,'manual')
set(vid,'TriggerRepeat',inf)
set(vid,'FramesPerTrigger',1)
start(vid);
trigger(vid);

%Getting the snapshot of the current frame
current_frame = getdata(vid);

%Assigning a variable for frame showing, fsh
fsh=imshow(current_frame);

%Variables for center and bounding box
cent=[];
box=150;

%The pictures array
picsArray=zeros(0,0);
ii=0;

cnt=zeros(1,50);

BoundingCirc=rectangle('Position',[0 0 1 1]);

Prediction=line(1,1);
TrackingLine=line(1,1);

hh=1;

pp=5;

lastPpoints=zeros(2,pp);
logind=1;
logini=zeros(1,1000000);
while(ii < 100)    
    
    ii=ii+1;
    
    % Get the snapshot of the current frame
    trigger(vid);
    current_frame  = getdata(vid);
    [cent  ,  box , radius] = find_ball_new(current_frame);
    set(fsh,'cdata',current_frame);
    %imshow(current_frame);
    picsArray{ii}=current_frame;
    if isempty(cent)   
        continue;
    end
     logini(logind)=ii;
     logind=logind+1;
    c = -1*radius: radius/20 : 1*radius;    
    r = sqrt(radius^2-c.^2);

    pos = [cent(1)-radius cent(2)-radius radius*2 radius*2];
    set(BoundingCirc,'Position',pos,'Curvature',[1 1],'EdgeColor','g');
    centHistory(1,hh)=cent(1);
    centHistory(2,hh)=cent(2);
    radiusHistory(hh)=radius;
    
    if hh<=pp
        set(TrackingLine,'xdata',centHistory(1,:),'ydata',centHistory(2,:),...
        'LineStyle' ,'-' ,'Marker' ,'+','Color', [0 0 1]);
    else
        lastPpoints=centHistory(:,end-4:end);
        xx=lastPpoints(1,3:5);
        yy=lastPpoints(2,3:5);
        [x,y]=predict(xx,yy);

        set(Prediction,'xdata',x,'ydata',y,'Marker','*','Color','c');
        set(TrackingLine,'xdata',lastPpoints(1,:),'ydata',lastPpoints(2,:),...
        'LineStyle' ,'-' ,'Marker' ,'+','Color', [0 0 1]);
     
    end
    
    hh=hh+1;
end

%Stop the video 
stop(vid);

%Flush all the data
flushdata(vid);
    