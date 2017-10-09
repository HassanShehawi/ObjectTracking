function [predictedX,predictedY] = predict (xn,yn)

checker=0;
tolerance=1;
dx1=abs(xn(1)-xn(2));
dx2=abs(xn(3)-xn(2));
dy1=abs(yn(1)-yn(2));
dy2=abs(yn(3)-yn(2));
slope1=(yn(2)-yn(1))/(xn(2)-xn(1));
slope2=(yn(3)-yn(2))/(xn(3)-xn(2));
slopes=[slope1 slope2];
slopeTolerance=0.08;

if (dx1<=tolerance && dx2<=tolerance) | (dy1<=tolerance && dy2<=tolerance)
    checker=1; %horizontal or vertical line
else
    if abs(slope2-slope1)<=slopeTolerance
        checker=2; %straightline
        avgslope=mean(slopes);
    else
        checker=3; %curve
    end
end

switch checker
    case 1
        if dx1<=tolerance && dx2<=tolerance
            if yn(end)-yn(end-1)>0
                predictedY=linspace(yn(end),480);
                predictedX=linspace(xn(end),xn(1));
            else
                predictedY=linspace(1,yn(end));
                predictedX=linspace(xn(end),xn(end));
            end
        end
        if dy1<=tolerance && dy2<=tolerance
            if xn(end)-xn(end-1)>0
                predictedX=linspace(xn(end),640);
                predictedY=linspace(yn(end),yn(end));
            else
                predictedX=linspace(1,xn(end));
                predictedY=linspace(yn(end),yn(end));
            end
        end
    case 2
        polyl=polyfit(xn(2:3),yn(2:3),1);
        if  xn(3)-xn(2)>0
            predictedX=linspace(xn(end),640);
            predictedY=polyval(polyl,predictedX);
        else
            predictedX=linspace(1,xn(end));
            predictedY=polyval(polyl,predictedX);
        end
    case 3
        polyn=polyfit(xn,yn,2);
        if xn(end)-xn(end-1)>0
            predictedX=linspace(xn(end),640);
            predictedY=polyval(polyn,predictedX);
        else
            predictedX=linspace(1,xn(end));
            predictedY=polyval(polyn,predictedX);
        end
end
        
        
    
% 
% if abs(xn(1)-xn(2))<=5 && abs(xn(3)-xn(2))<=20
%     if yn(end)-yn(end-1)>0
%         predictedY=linspace(yn(end),480);
%         predictedX=linspace(xn(end),xn(end));
%     else
%         predictedY=linspace(1,yn(end));
%         predictedX=linspace(xn(end),xn(end));
%     end
% else
%     polyn=polyfit(xn,yn,2);
%     if xn(end)-xn(end-1)>0
%         predictedX=linspace(xn(1),640);
%         predictedY=polyval(polyn,predictedX);
%     else
%         predictedX=linspace(1,xn(1));
%         predictedY=polyval(polyn,predictedX);
%     end
% end