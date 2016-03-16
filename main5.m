load planes.mat



% figure(2)
% hold on
% points = 0;



% for i = 1 : 10
%     for j = 1 : 10
%         for k = 1 : 10
%           plane1 = planes(i,:);
%           plane2 = planes(j,:);
%           plane3 = planes(k,:);
%           coeff = [plane1; plane2; plane3];
%           coeff = coeff(:,1:3);
%           if rank(coeff) == 3
%               points = points + 1;
%               point_of_intersection(points,:) = planes_intersect_point(plane1, plane2, plane3);
%               
%           end
% 
%         end
%     end
% end
% points
% plot3(point_of_intersection(:,1), point_of_intersection(:,2), point_of_intersection(:,3), 'kd')

% for i = 1 : 10
%     for j = i : 10
%         
%     end
% end