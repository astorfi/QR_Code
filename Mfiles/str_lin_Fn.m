function [m, b] = str_lin_Fn(x1, y1, x2, y2)
if x1 == x2
    x=x1
else
m = (y2-y1) / (x2-x1);
b = y1 - m*x1;
end
end

