format bank
mcolor = {'g', 'r', 'b', 'y', 'm', 'w', 'k'};
load('av_pcl.mat');
clf
fg_clouds = {};
for f = 1 : 16
    f
    R = pcl_cell{f};
    R(:,:,4:6) = R(:,:,4:6) * 1000;
    [L,W,~] = size(R);
    R = reshape(R, L*W, 6);
    depth_cloud = R;
    
    % remove 0 row
    depth_cloud = depth_cloud(logical(depth_cloud(:,4))  ...
        & logical(depth_cloud(:,5)) & logical(depth_cloud(:,6)),:);
    
    accepted = false;
    while ~accepted
        fg_cloud = backgroundsub(depth_cloud);
        
        % remove ouliner
        [Row, ~] = size(fg_cloud);
        centoid = mean(fg_cloud(:,4:6));
        stdv = sum(std(fg_cloud(:,4:6)),2);
        filter = sum(abs(fg_cloud(:,4:6) - repmat(centoid, Row, 1)),2) ...
            < (repmat(stdv, Row, 1) * 3.0);
        fg_cloud = fg_cloud(filter',:);
        
        [idx, C, sumd, D] = kmeans(fg_cloud(:,4:6), 4, 'Replicates', 3);
        
        distanceMatrix = squareform(pdist(C));
        stdvDist = std(mean(distanceMatrix))
        if stdvDist >= 41 && stdvDist <= 45
            accepted = true;
        end 
    end
    
%     figure(f)
%     clf
%     hold on
%     pcshow(fg_cloud(:,4:6))
%     hold on
%     plot3(C(:,1), C(:,2), C(:,3), 'gh')
    
    fg_clouds{f} = fg_cloud;
    
    
end
% save fg.mat fg_clouds
