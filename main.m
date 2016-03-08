color = {'g', 'r', 'b', 'y', 'm', 'w', 'k'};
load('av_pcl.mat');
R = pcl_cell{1} * 1000;
[L,W,D] = size(R);
% c = 0;
% for i = 1 : L
%     for j = 1 : W
%         if sum(R(i,j,4:6)) == 0
%             c = c + 1;
%             R(i,j,1:3) = [255 0 0];
%             
%         end
%     end
% end
% c
% imshow(uint8(R(:,:,1:3)))
% pause

R = reshape(R, L*W, 6);
figure(1)
clf
hold on
plot3(R(:,4),R(:,5),R(:,6),'k.')

% extrac background
depth_cloud = R(:,4:6);
% remove 0 row
depth_cloud = depth_cloud(any(depth_cloud,2),:);
[L,W] = size(depth_cloud);
for i = 1 : 1

    [oldlist, plane] = select_patch(depth_cloud);
    plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3), 'r.')
    

    while true
        
        [newlist, depth_cloud] = getallpoints(plane, oldlist, depth_cloud, L);
        plot3(newlist(:,1),newlist(:,2),newlist(:,3), 'r.')
        pause(0.1)
        
        [Nold, W] = size(oldlist);
        [Nnew, W] = size(newlist);
        
        if Nnew > Nold + 50
            [plane, fit] = fitplane(newlist)
%             if fit > 0.04*NewL       % bad fit - stop growing
%                 ['bad fit']
%                 break
%             end
            oldlist = newlist;
        else
            break
        end
        
    end
    
end

% [NPts,W] = size(R);
% patchid = zeros(NPts,1);
% planelist = zeros(20,4);
% 
% % find surface patches
% % here just get 5 first planes - a more intelligent process should be
% % used in practice. Here we hope the 4 largest will be included in the
% % 5 by virtue of their size
% remaining = R;
% for i = 1 : 4   
% 
%   % select a random small surface patch
%   [oldlist,plane] = select_patch(remaining);
% 
%   % grow patch
%   stillgrowing = 1;
%   while stillgrowing
% 
%     % find neighbouring points that lie in plane
%     stillgrowing = 0;
%     [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts);
%     [NewL,W] = size(newlist);
%     [OldL,W] = size(oldlist);
% if i == 1
%  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')
%  save1=newlist;
% elseif i==2 
%  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'b.')
%  save2=newlist;
% elseif i == 3
%  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'g.')
%  save3=newlist;
% elseif i == 4
%  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'c.')
%  save4=newlist;
% else
%  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'m.')
%  save5=newlist;
% end
% pause(1)
%     
%     if NewL > OldL + 50
%       % refit plane
%       [newplane,fit] = fitplane(newlist);
% [newplane',fit,NewL]
%       planelist(i,:) = newplane';
%       if fit > 0.04*NewL       % bad fit - stop growing
%         break
%       end
%       stillgrowing = 1;
%       oldlist = newlist;
%       plane = newplane;
%     end
%   end
% 
% waiting=1
% 	 pause(1)
% 
% ['**************** Segmentation Completed']

