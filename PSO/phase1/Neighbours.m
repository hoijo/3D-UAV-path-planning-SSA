function [CurrentNeighbours,ViableNeighbours] = Neighbours(CurrentNode, sizeX, sizeY, sizeZ,Boundaryinitial, Boundaryfinal, AllPoints,directions)
% sizeX = size(DummyX,1);
% sizeY = size(DummyY,1);
% sizeZ = size(DummyZ,1);
% CurrentNode = 2;
% CurrentNode = 25275;
if sizeZ==0
    A = sizeY*sizeX;
else
    A = sizeZ*sizeY*sizeX;
end
CurrentNeighbours = [ CurrentNode + sizeY;          CurrentNode - sizeY;...     % for x
                      CurrentNode+1;                CurrentNode-1;  ...         % for y                      
                      CurrentNode + sizeY*sizeX;    CurrentNode - sizeY*sizeX]; % for z
ViableNeighbours = [];

% for x direction
if directions(1) == 1       % if curr_x > goal_x
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(2)];
elseif directions(1) == 0   % if curr_x < goal_x
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(1)];
else                        % if curr_x = goal_x
    ViableNeighbours = [ViableNeighbours;NaN];
end

% for y direction
if directions(2) == 1       % if curr_y > goal_y
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(4)];
elseif directions(2) == 0   % if curr_y < goal_y
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(3)];
else                        % if curr_y = goal_y
    ViableNeighbours = [ViableNeighbours;NaN];
end

% for z direction
if directions(3) == 1       % if curr_z > goal_z
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(6)];
elseif directions(3) == 0   % if curr_z < goal_z
    ViableNeighbours = [ViableNeighbours;CurrentNeighbours(5)];
else                        % if curr_z = goal_z
    ViableNeighbours = [ViableNeighbours;NaN];
end



% if directions(1)<2
%     oned = CurrentNeighbours(directions(1) + 1);
% else
%     oned =NaN;
% end
% if directions(2)<2
%     twod = CurrentNeighbours(directions(2) + 3);
% else
%     twod =NaN;
% end
% if directions(3)<2
%     threed = CurrentNeighbours(directions(3) + 5);
% else
%     threed =NaN;
% end
% ViableNeighbours = [oned;twod;threed];

% Bound checks
if AllPoints(CurrentNode,1)==Boundaryinitial(1)     % Bound check for x-min
    CurrentNeighbours(2) = NaN;
    if directions(1) == 1
        ViableNeighbours(1)= NaN;
    end
end
if AllPoints(CurrentNode,1)==Boundaryfinal(1)     % Bound check for x-max
    CurrentNeighbours(1) = NaN;
    if directions(2) == 0
        ViableNeighbours(1)= NaN;
    end
end
if AllPoints(CurrentNode,2)==Boundaryinitial(2)   % Bound check for y-min
    CurrentNeighbours(4) = NaN;
    if directions(2) == 1
        ViableNeighbours(2)= NaN;
    end
end
if AllPoints(CurrentNode,2)==Boundaryfinal(2)   % Bound check for y-max
    CurrentNeighbours(3) = NaN;
    if directions(2) == 0
        ViableNeighbours(2)= NaN;
    end
end
if AllPoints(CurrentNode,3)==Boundaryinitial(3)   % Bound check for z-min
    CurrentNeighbours(6) = NaN;
    if directions(3) == 1
        ViableNeighbours(3)= NaN;
    end
end
if AllPoints(CurrentNode,3)==Boundaryfinal(3)   % Bound check for z-max
    CurrentNeighbours(5) = NaN;
    if directions(3) == 0
        ViableNeighbours(3)= NaN;
    end
end


CurrentNeighbours(isnan(CurrentNeighbours(:,1)),:)=[]; % deleting NaN from the array
CurrentNeighbours = (CurrentNeighbours(CurrentNeighbours>=0 & CurrentNeighbours<=A)); %delete element if thry are not in limit

ViableNeighbours(isnan(ViableNeighbours(:,1)),:)=[];
ViableNeighbours = (ViableNeighbours(ViableNeighbours>=0 & ViableNeighbours<=A));



end
% for i=1:size(CurrentNeighbours,1)
% %     a = sum(abs(AllNodes(1:j,1:3)-ones(j,1)*CurrentNeighbours(i,1:3)),2)<1e-5;
% %     a = ismember(AllNodes(:,1:3),CurrentNeighbours(i,1:3),'rows');
%     if (CurrentNeighbours(i,1)<map(1,4)||CurrentNeighbours(i,1)>map(2,4)||...
%             CurrentNeighbours(i,2)<map(1,5)||CurrentNeighbours(i,2)>map(2,5)||...
%             CurrentNeighbours(i,3)<map(1,6)||CurrentNeighbours(i,3)>map(2,6))
%         CurrentNeighbours(i,:) = NaN;
%     elseif any(a==1) 
%         CurrentNeighbours(i,:) = NaN;
%     else
%         check = trycollide(map,CurrentNeighbours(i,:));
%         if check == 1
%             CurrentNeighbours(i,:) = NaN;
%         end
%     end
% end
% CurrentNeighbours(isnan(CurrentNeighbours(:,1)),:)=[];
% CurrentNeighbours(:,4) = 0;
% % j=find(AllNodes(:,4), 1, 'last' );
% % CurrentNeighbours(:,4) = j+1:j+size(CurrentNeighbours,1);
% % AllNodes(j+1:j+size(CurrentNeighbours,1),:) = CurrentNeighbours;
% % AllNodes = unique(AllNodes,'rows');
% end
