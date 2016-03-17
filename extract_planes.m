%%
% Function which extracts planes
% Author: Edward Stevinson
%%

function [plane_list, points_matrix] = extract_planes(point_cloud, colours)

[num_points_in_cloud, ~] = size(point_cloud);
% patch_id?
%patch_id = zeros(num_points_in_cloud,1);
% Store plane parameters
plane_list = zeros(9,4);
points_matrix = cell(1,9); %...?

% Note - more intelliigent method recommended
remaining_point_cloud = point_cloud;

plane_no = 0;

% Iterate over ... ?
while true
    
    % Select a random small surface patch (thereby hoping to get the
    % biggest - but this is not the case)
    % Look at this funtion - change it!
    [old_list, plane] = select_starting_patch2(remaining_point_cloud);
    
    
    %% Grow patch
    while (true)
        
        [list_of_points_on_plane, remaining] = getallpoints2(plane, old_list, remaining_point_cloud, num_points_in_cloud);
        % Because MATLAB is funny...
        remaining_point_cloud = remaining;
        % Store ...
        [number_points_plane, ~] = size(list_of_points_on_plane);
        [length_oldlist, ~] = size(old_list);
        
        [plane, ~] = fitplane(list_of_points_on_plane(:, 1:3));
        if (number_points_plane > length_oldlist + 40) || number_points_plane < 1000
            old_list = list_of_points_on_plane;
        else
            plane_no = plane_no + 1;
            plane_list(plane_no,:) = plane';
            points_matrix{plane_no} = list_of_points_on_plane;
            [L, ~] = size(list_of_points_on_plane)
            figure(2)
            hold on
            scatter3(list_of_points_on_plane(:, 1), ...
                list_of_points_on_plane(:, 2), ...
                list_of_points_on_plane(:, 3), [], colours{plane_no}, '.')
            
            break
        end
    end
    [num_points_in_cloud,~] = size(remaining_point_cloud);
    figure(1)
    pcshow(remaining_point_cloud(:,1:3))
    pause(0.5)
    
    if plane_no == 9
        break
    end
end
end