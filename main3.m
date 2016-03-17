load balls.mat
load fg.mat
load obj.mat
load bg_planes.mat

% balls(1) = [];
% fg_clouds(1) = [];
% obj(1) = [];

% 
% base_idx = 2;
% base = balls{base_idx};


fuse_obj = [];
R = cell(1,16) ;
t = cell(1,16);

%% evel fuse
mean_err = zeros(16,1);
err = cell(1,16);

for base_idx= 1:size(balls,2)
    tran_bg_norm = zeros(16,3);
    norm_vector_diff = zeros(1,16);
    base = balls{base_idx};
    for f = 1 : size(balls,2)
        cloud = fg_clouds{f}(:,4:6) / 1000;
        [L,~] = size(obj{f});
        [R{f}, t{f}] = estPose(balls{f} / 1000, base /1000);
        bg = bg_planes(f,1:3);
        tran_bg_norm(f,:) = (R{f} * bg' + t{f})';
        norm_vector_diff(f) = acos(dot(bg_planes(base_idx, 1:3), tran_bg_norm(f,:)) ...
            / (norm(bg_planes(base_idx, 1:3)) * norm(tran_bg_norm(f,:))));
    end
    err{base_idx} = radtodeg(norm_vector_diff);
    mean_err(base_idx) = (mean(err{base_idx}));
end
min(mean_err)
base_idx = find(mean_err == min(mean_err));
err{base_idx}

%%
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


%%


figure(1)
size(fuse_obj)
pcshow(fuse_obj)

save fuse.mat fuse_obj