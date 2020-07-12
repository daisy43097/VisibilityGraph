function S = get_vertices_obs(CB)
[~,c] = size(CB);
S = [];
for i = 1:c
    S = [S CB{1,i}];
end 
