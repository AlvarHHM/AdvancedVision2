function [ remaining ] = backgroundsub( depth_cloud )

% figure(1)
% plot3(depth_cloud(:,1),depth_cloud(:,2),depth_cloud(:,3),'k.')
% pause(1)
[L,~] = size(depth_cloud);
while L > 100000
    [L,~] = size(depth_cloud);
    [oldlist, plane] = select_patch(depth_cloud);
    plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3), 'r.')
    
    
    while true
        
        [newlist, depth_cloud] = getallpoints(plane, oldlist, depth_cloud, L);
%         plot3(newlist(:,1),newlist(:,2),newlist(:,3), 'r.')
%         pause(0.1)
        
        [Nold, ~] = size(oldlist);
        [Nnew, ~] = size(newlist);
        
        if Nnew > Nold + 50
            [plane, ~] = fitplane(newlist(:,4:6));
            oldlist = newlist;
        else 
            remaining = depth_cloud;
            size(remaining);
            break;
        end
        
    end
    [L,~] = size(depth_cloud);
end
end

