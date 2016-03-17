function [ remaining, plane ] = backgroundsub( depth_cloud )

% figure(1)
% plot3(depth_cloud(:,4),depth_cloud(:,5),depth_cloud(:,6),'k.')
% pause
[L,~] = size(depth_cloud);
while L > 100000
    [L,~] = size(depth_cloud);
    [oldlist, plane] = select_patch(depth_cloud);
%     plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3), 'r.')
    
    
    while true
        
        [newlist, depth_cloud] = getallpoints(plane, oldlist, depth_cloud, L);
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6), 'r.')
%         pause(0.1)
        
        [Nold, ~] = size(oldlist);
        [Nnew, ~] = size(newlist);
        
        if Nnew > Nold + 50
            [plane, ~] = fitplane(newlist(:,4:6));
            oldlist = newlist;
        else 
            [plane, ~] = fitplane(newlist(:,4:6));
            remaining = depth_cloud;
            size(remaining);
            break;
        end
        
    end
    [L,~] = size(depth_cloud);
end
end

