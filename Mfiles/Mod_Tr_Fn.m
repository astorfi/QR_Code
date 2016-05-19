%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function out = Mod_Tr_Fn(vector)
%
%If the vector in is [0 0 1 0 1 1 1 0 0], out = [2 1 1 3 2].
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = Mod_Tr_Fn(In)
    % allocate with ones
    out = ones(1,length(In));
    k=1;
    
    for i = 1 : length(In)-1
        if (In(i) == In(i+1))
            out(k) = out(k) + 1;
        else
            k = k + 1;
        end
    end

    out = out(1:k);
end

