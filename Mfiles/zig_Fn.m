function output = zig_Fn(im,mode)

% initializing the variables
%----------------------------------
r_max = size(im, 1);
c_max = size(im, 2);

% Predifinition
output = zeros(1, r_max * c_max);
%----------------------------------
switch mode         % Changing mode
    case 1      % Going up
        c=1;
           for i=r_max:-1:1
             for j=c_max:-1:1
                output(c) = im(i,j);
                c=c+1;
             end
           end
    case -1     % Going down
           c=1;
           for i=1:r_max
             for j=c_max:-1:1
                output(c) = im(i,j);
                c=c+1;
             end
           end
end