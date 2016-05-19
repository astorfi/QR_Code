%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function [out, moduleSize] = checkRatio_Fn(vector, pattern)
%
%Check ratio of the vector that is sent in. Example if search for FIP,
%the pattern is [1 1 3 1 1] or search for AP is [1 1 1].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [out, moduleSize] = checkRatio_Fn(A, Pat)
    % total size of all the pixels in the sequence we looking at
    Size = sum(A);
    
    % size of the modules, ex 7 for the FIP-finder
    pat_Size = sum(Pat);
    
    % if smaller than pattern size, no pattern found
    if(Size < pat_Size)
        out = false;
    end

    % Calculate the size of one module
    Cor_coeff = 0.4;    % Deafaul is 0.4
    moduleSize = (Size / pat_Size);
    
    % how much the pattern can vary and still be acceptable. 
    maxV = moduleSize * Cor_coeff;

    % determine if the vector is good enough
    if(abs( moduleSize .* Pat - A) <= maxV)
        out = true;
    else
        out = false;

    end
end