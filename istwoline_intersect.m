function b = istwoline_intersect(p1, p0, O)
u = p0 - p1;
for i = 1:size(O,2)
    q0 = O(1:2,i);
    q1 = O(3:4,i);
    v = q1 - q0;
    P = abs(dot(u,v)/(norm(u)*norm(v)));
    if P == 1
        r(i) = false;
    else
        A = [u v];
        b = p0 - q0;
        x =A\b;
        s = x(1,1);
        t = x(2,1);
        if 0<s && s<1 && 0<t && t<1
            r(i) = true;
        elseif ((s==1 || s==0) && 0<t && t<1) || ((t==1 || t==0) && 0<s && s<1)
            r(i) = true;
        elseif (s==0 || s==1) && (t==0 || t==1)
            r(i) = false;
        else
            r(i) = false;
        end
    end
end
if find(r==1)
    b = true;
else 
    b = false;
end 
