load balls.mat
load fg.mat
load obj.mat
load bg_planes.mat

% balls(1) = [];
% fg_clouds(1) = [];
% obj(1) = [];


base_idx = 2;
base = balls{base_idx};


fuse_obj = [];
R = cell(1,16) ;
t = cell(1,16);
for f = 1: size(balls,2)
    cloud = fg_clouds{f}(:,4:6) / 1000;
    [L,~] = size(obj{f});
    [R{f}, t{f}] = estPose(balls{f} / 1000, base /1000);
    trans_obj = R{f} * obj{f}(:,4:6)' / 1000 + repmat(t{f}, 1, L);
    trans_obj = trans_obj';
    fuse_obj = [fuse_obj;trans_obj];
end

%% evel fuse
norm_vector_diff = zeros(1,15);

tran_bg_norm = zeros(16,3);
for f = 1 : size(balls,2)
    bg = bg_planes(f,1:3);
    tran_bg_norm(f,:) = (R{f} * bg' + t{f})';
    norm_vector_diff(f) = acos(dot(bg_planes(base_idx, 1:3), tran_bg_norm(f,:)) ...
        / (norm(bg_planes(base_idx, 1:3)) * norm(tran_bg_norm(f,:))));
end
radtodeg(mean(norm_vector_diff))

%%


figure(1)
size(fuse_obj)
pcshow(fuse_obj)

save fuse.mat fuse_obj