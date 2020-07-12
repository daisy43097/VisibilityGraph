function [G, Gw, V, E] = visibility_graph(qI, qG, CB)
O = get_line_segments(CB); % get the obstacles line segments 
S = get_vertices_obs(CB);
if ispt_inV(qI, S) == 0
    V = [qI S];
end 
if ispt_inV(qG, S) == 0
    V = [V qG];
end
V = reorder(V, 1);
E = [];
EI = [];
weights = [];
for i = 1:size(V,2)
    P = V;
    P(:,i) = [];
    for k = 1:size(P,2)
        if istwopts_inoneobs(V(:,i), P(:,k), CB) == 1
            E = [E];
        elseif istwoline_intersect(V(:,i), P(:,k),O) == 0
            E = [E [V(:,i);P(:,k)]];
            EI = [EI [find_index(V(:,i), V);find_index(P(:,k), V)]];
            weights = [weights [dist(V(:,i),P(:,k))]];
        end
    end
end
[~,c] = size(CB);
Ls = [];
for m = 1:c
    obs = CB{1,m};
    Ls1 = get_line_segments_onepoly(obs);
    Ls2 = [Ls1(3:4,:);Ls1(1:2,:)];
    Ls = [Ls Ls1 Ls2];
end
Ls_in = [];
for q = 1:size(Ls,2)
    Ls_in = [Ls_in [find_index(Ls(1:2,q), V);find_index(Ls(3:4,q), V)]];
end 
Ls_w = [];
for n = 1:size(Ls,2)
    Ls_w = [Ls_w [dist(Ls(1:2,n), Ls(3:4,n))]];
end 
E = [E Ls];
EI = [EI Ls_in];
weights = [weights Ls_w];
n_nodes = size(V,2);
Gw = ones(n_nodes)*Inf;
G = ones(n_nodes)*Inf;
for i = 1 : n_nodes
    Gw(i,i) = 0;
    G(i,i) = 0;
end
for i = 1:size(EI,2)
    Gw(EI(1,i),EI(2,i)) = weights(i);
    Gw(EI(2,i),EI(1,i)) = weights(i);
    G(EI(1,i),EI(2,i)) = 1;
    G(EI(2,i),EI(1,i)) = 1;
end 
