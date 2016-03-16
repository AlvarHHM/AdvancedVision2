load balls.mat
load fg.mat
load obj.mat
load bg_planes.mat

base = balls{2};


fuse_obj = [];
R = cell(1,16) ;
t = cell(1,16);
for f = 1: 16
    cloud = fg_clouds{f}(:,4:6);
    [L,~] = size(obj{f});
    [R{f}, t{f}] = estPose(balls{f}, base);
    trans_obj = R{f} * obj{f}(:,4:6)' + repmat(t{f}, 1, L);
    trans_obj = trans_obj';
    fuse_obj = [fuse_obj;trans_obj];
end

%% evel fuse
norm_vector_diff = zeros(1,16);
for f = 1 : 16
    bg = bg_planes(f,1:3);
    tran_bg_norm = R{f} * bg' + t{f};
%     figure(3)
%     hold on
%     plotv(tran_bg_norm, '-')
    norm_vector_diff(f) = acos(dot(base(1:3), tran_bg_norm) / norm(base(1:3) * tran_bg_norm));
end
norm_vector_diff

%%

% remove ouliner
% [Row, ~] = size(fuse_obj);
% centoid = mean(fuse_obj);
% stdv = sum(std(fuse_obj),2);
% filter = sum(abs(fuse_obj - repmat(centoid, Row, 1)),2) ...
%     < (repmat(stdv, Row, 1) * 1.45);
% fuse_obj = fuse_obj(filter',:);

figure(1)
size(fuse_obj)
pcshow(fuse_obj)

save fuse.mat fuse_obj