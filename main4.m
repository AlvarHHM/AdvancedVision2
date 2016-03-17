format bank
%%
% Assignment 2 - Questions 4 and 5
%%

% Clear figures
clf

% Load point cloud 
load('fuse.mat');
point_cloud_noisy = fuse_obj * 1000;
% Colour list
colour_list = {'g', 'r', 'b', 'y', 'm', 'c', 'k',[0.5 0.0 0.5], [1 0.64 0.0]};

%% Remove some noise
% Turn point cloud into object
point_cloud_noisy_object = pointCloud(point_cloud_noisy(:,1:3));
% Remove noise from this object
[~, ~, outlier_indices] = pcdenoise(point_cloud_noisy_object, 'Threshold', 1);
% Remove ouliers from point cloud
point_cloud = removerows(point_cloud_noisy,'ind',outlier_indices);
% Get size of point cloud
[number_of_points, ~] = size(point_cloud);
% Plot this object
pcshow(point_cloud(:, 1:3))

%%
[L,~] = size(point_cloud);
point_cloud = repmat(point_cloud, 1, 2);
point_cloud = point_cloud(rand(L,1) > 0,:);
pcshow(point_cloud(:,1:3))
pause(0.2)
%% Extract planes
[planes, points_matrix] = extract_planes(point_cloud, colour_list);

%% angle between normal of the planes
angles = zeros(9,9);
for i = 1: 9
   for j = 1: 9
       plane1 = planes(i,1:3);
       plane2 = planes(j,1:3);
       
       angles(i,j) = acos(dot(plane1(1:3), plane2) / (norm(plane1) * norm(plane2)));
   end
end
radtodeg(angles)
%% Calculate Points
ground_plane = [0, -0.57, 0.82, -749.3];
%all_planes = [planes; ground_plane];
%get_vertices(all_planes)

%% Draw Patches
%draw_patches(vertices)





