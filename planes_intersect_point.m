%% 
% Function that finds intersection of 3 planes
% Each Plane is in the form:
%      A * X + B * Y + C * Z + D = 0
% Author: Geometry by Bowyer andf Woodwark, Butterworths, 1983
%%

function p = planes_intersect_point( plane1, plane2, plane3 )

    a1 = plane1(1); b1 = plane1(2); c1 = plane1(3); d1 = plane1(4);
    a2 = plane2(1); b2 = plane2(2); c2 = plane2(3); d2 = plane2(4);
    a3 = plane1(1); b3 = plane3(2); c3 = plane3(3); d3 = plane3(4);

    tol = eps;

    bc = b2*c3 - b3*c2;
    ac = a2*c3 - a3*c2;
    ab = a2*b3 - a3*b2;

    det = a1*bc - b1*ac + c1*ab;

    if (abs(det) < tol)
        p = -1;
        return;
        error('planes_3d_3_intersct: At least to planes are parallel');
    else
        dc = d2*c3 - d3*c2;
        db = d2*b3 - d3*b2;
        ad = a2*d3 - a3*d2;
 
        detinv = 1/det;
 
        p(1) = (b1*dc - d1*bc - c1*db)*detinv;
        p(2) = (d1*ac - a1*dc - c1*ad)*detinv;
        p(3) = (b1*ad + a1*db - d1*ab)*detinv;
 
        return;
    end
end