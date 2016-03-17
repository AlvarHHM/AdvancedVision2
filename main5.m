load planes.mat
figure(13)
clf
p = [
    planes_intersect_point(planes(8,:), planes(6,:), planes(9,:));
planes_intersect_point(planes(9,:), planes(6,:), planes(7,:));
planes_intersect_point(planes(7,:), planes(6,:), planes(3,:));
planes_intersect_point(planes(3,:), planes(6,:), planes(8,:));
% planes_intersect_point(planes(9,:), planes(5,:), planes(8,:));
% planes_intersect_point(planes(8,:), planes(5,:), planes(6,:));
% planes_intersect_point(planes(6,:), planes(5,:), planes(7,:));
% planes_intersect_point(planes(7,:), planes(5,:), planes(9,:))
];



plot3(p(:,1),p(:,2),p(:,3), 'kd')

