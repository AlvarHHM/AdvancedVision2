%%
% File to get the coordinates of the vertices of the object
%%

%vertices = get_vertices(plane_list)
plane_list = zeros(10,4);
plane_list(1,:) = [3,2,1,5];
plane_list(2,:) = [1,1,2,4];
plane_list(10,:) = [1,3,4,5];

vertex1 = planes_intersect_point(plane_list(1,:) , plane_list(2,:), plane_list(10,:));
vertex2 = planes_intersect_point(plane_list(2,:) , plane_list(3,:), plane_list(10,:));
vertex3 = planes_intersect_point(plane_list(3,:) , plane_list(4,:), plane_list(10,:));
vertex4 = planes_intersect_point(plane_list(4,:) , plane_list(1,:), plane_list(10,:));

