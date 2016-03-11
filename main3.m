load balls.mat
load fg.mat
load obj.mat

base = balls{2};


fuse_obj = [];
for f = 1: size(balls,2)
    cloud = fg_clouds{f}(:,4:6);
    [L,~] = size(obj{f});
    [R, t] = estPose(balls{f}, base);
    trans_obj = R * obj{f}(:,4:6)' + repmat(t, 1, L);
    trans_obj = trans_obj';
    fuse_obj = [fuse_obj;trans_obj];
end

% remove ouliner
% [Row, ~] = size(fuse_obj);
% centoid = mean(fuse_obj);
% stdv = sum(std(fuse_obj),2);
% filter = sum(abs(fuse_obj - repmat(centoid, Row, 1)),2) ...
%     < (repmat(stdv, Row, 1) * 1.45);
% fuse_obj = fuse_obj(filter',:);


size(fuse_obj)
pcshow(fuse_obj)

save fuse.mat fuse_obj