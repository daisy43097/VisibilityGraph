%% test for get vertices 

CB = {[0 50 50 0;25 25 50 50], [80 80 70 70; 50 100 100 50]};
S = get_vertices_obs(CB);

%% test for twopts in one polygon

clear
clc
CB = {[0 50 50 0;25 25 50 50], [80 80 70 70; 50 100 100 50]};
p0 = [0;25];
p1 = [20;20];
b = istwopts_inoneobs(p0, p1, CB)


%% visibility graph

clear
clc
CB = {[0 2 3 2 0 -1; -7 -7 -5 -3 -3 -5], [-1 0 1 1 -2 -2; -2 -2 0 1 1 0]};
qI = [-5;4];
qG = [10;-8];
[G, Gw, V, E] = visibility_graph(qI, qG, CB)
o1 = CB{1,1}; o2 = CB{1,2};
pg1 = polyshape([o1(1,:) o1(1,1)],[o1(2,:) o1(2,1)]);
plot(pg1)
hold on
pg2 = polyshape([o2(1,:) o2(1,1)],[o2(2,:) o2(2,1)]);
plot(pg2)
for i = 1:size(E,2)
    plot([E(1,i) E(3,i)], [E(2,i) E(4,i)])
    hold on
end 

%% test for consecutive edges 

clear
clc
CB = {[0 2 3 2 0 -1; -7 -7 -5 -3 -3 -5], [-1 0 1 1 -2 -2; -2 -2 0 1 1 0]};
[~,c] = size(CB);
Ls = [];
for m = 1:c
    obs = CB{1,m};
        Ls1 = get_line_segments_onepoly(obs);
        Ls2 = [Ls1(3:4,:);Ls1(1:2,:)];
   Ls = [Ls Ls1 Ls2]
end 