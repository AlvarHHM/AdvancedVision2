format bank
mcolor = {'g', 'r', 'b', 'y', 'm', 'w', 'k'};
load('av_pcl.mat');
clf
fg_clouds = {};
for f = 1 : 16
    f
    figure(f)
    hold on
    R = pcl_cell{f};
    R(:,:,4:6) = R(:,:,4:6) * 1000;
    [L,W,~] = size(R);
    R = reshape(R, L*W, 6);
    
    
    
    % extrac background
    depth_cloud = R;
    %     plot3(depth_cloud(:,1),depth_cloud(:,2),depth_cloud(:,3),'k.')
    % remove 0 row
    depth_cloud = depth_cloud(logical(depth_cloud(:,4))  ...
        & logical(depth_cloud(:,5)) & logical(depth_cloud(:,6)),:);
    
    accepted = false;
    while ~accepted
        disp('try bgsub')
        fg_cloud = backgroundsub(depth_cloud);
        
        % remove ouliner
%         distanceMatrix = squareform(pdist(depth_cloud(:,4:6)));
%         filter = mean(distanceMatrix) < mean(mean(distanceMatrix)) * 2.5;
%         depth_cloud = depth_cloud(filter',:);
        [Row, ~] = size(fg_cloud);
        centoid = mean(fg_cloud(:,4:6));
        stdv = sum(std(fg_cloud(:,4:6)),2);
        filter = sum(abs(fg_cloud(:,4:6) - repmat(centoid, Row, 1)),2) ...
            < (repmat(stdv, Row, 1) * 2.5);
        fg_cloud = fg_cloud(filter',:);
        
        [idx, C, sumd, D] = kmeans(fg_cloud(:,4:6), 4, 'Replicates', 3);
        
        distanceMatrix = squareform(pdist(C));
        stdvDist = std(mean(distanceMatrix))
        if stdvDist >= 41 && stdvDist <= 45
            accepted = true;
        end
        
    end
    
    
    
    figure(f)
    clf
    hold on
    pcshow(fg_cloud(:,4:6))
    hold on
    plot3(C(:,1), C(:,2), C(:,3), 'gh')
    
    fg_clouds{f} = fg_cloud;
    
    save fg.mat fg_clouds
    
    %     hsvcolor= zeros(numel(unique(idx)), 3)
    %     for i = 1 : numel(unique(idx))
    %         clust = depth_cloud(idx == i,:);
    %         color = mean(clust(:,1:3));
    %         color = color / 255;
    %         hsvcolor = hsv2rgb(color);
    %         [size(clust,1), hsvcolor]
    %
    % %         if hsvcolor(1) > 0.7
    % %          scatter3(clust(:,4), clust(:,5), clust(:,6),[],[0 1 0])
    % %         elseif hsvcolor(1) > 0.1 && hsvcolor(1) < 0.2
    % %            scatter3(clust(:,4), clust(:,5), clust(:,6),[],[1 0 0])
    % %         elseif hsvcolor(1) > 0.2 && hsvcolor(1) < 0.7
    % %             scatter3(clust(:,4), clust(:,5), clust(:,6),[],[0 0 1])
    % %         end
    %
    % %         scatter3(clust(:,4), clust(:,5), clust(:,6),[],color)
    %
    %     end
    
    
    
    %
    %     if valid_ball_clust == 3
    %         valid_depth_clouds{f} = depth_cloud;
    %     end
    
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

