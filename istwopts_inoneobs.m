function b = istwopts_inoneobs(p0, p1, CB)
[~,c] = size(CB);
for i = 1:c
    obs = CB{1,i};
    [~,on1] = inpolygon(p0(1), p0(2), obs(1,:), obs(2,:));
    if on1 
        [~,on2] = inpolygon(p1(1), p1(2), obs(1,:), obs(2,:));
        if on2
            r(i) = true;
        else 
            r(i) = false;
        end 
    else 
        r(i) = false;
    end 
end 

if find(r==1)
    b = true;
else 
    b = false;
end 
    