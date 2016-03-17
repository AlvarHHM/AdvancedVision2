% selects all points in pointlist P that fit the plane and are within
% TOL of a point already in the plane (oldlist)
function [newlist,remaining] = getallpoints(plane,oldlist,P,NP)

pnt = ones(4,1);
[N,~] = size(P);
%   oldlist = flipud(oldlist);
[Nold,~] = size(oldlist);
DISTTOL = 5;
tmpnewlist = zeros(NP,6);   
tmpnewlist(1:Nold,:) = oldlist;       % initialize fit list
tmpremaining = zeros(NP,6);           % initialize unfit list
countnew = Nold;
countrem = 0;
oldlist_center = mean(oldlist(:,4:6));
dist2center = max(sum(abs(oldlist(:,4:6) - repmat(oldlist_center, Nold,1)),2));
max_dist = (dist2center * 1.5);

for i = 1 : N
    pnt(1:3) = P(i,4:6);
    notused = 1;
    % see if point lies in the plane
    if norm(oldlist_center - P(i,4:6)) < max_dist && abs(pnt'*plane) < DISTTOL
        % see if an existing nearby point already in the set
        countnew = countnew + 1;
        tmpnewlist(countnew,:) = P(i,:);
        notused = 0;
    end
    
    if notused
        countrem = countrem + 1;
        tmpremaining(countrem,:) = P(i,:);
    end
end

newlist = tmpnewlist(1:countnew,:);
remaining = tmpremaining(1:countrem,:);
countnew;
countrem;
Nold;

