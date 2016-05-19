%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function [B_point, A_point, C_point] = get_Correct_Order_FIPs_Fn(FIPs)
%
% Input = three FIP locations & Output= return known order of these.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [B_point, A_point, C_point] = get_Correct_Order_FIPs_Fn(FIPs)

    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    [~,Max_indx] = max(pdist(FIPs)); % calculation of maximum distance which belongs to BC
    
    %% Find the top left FIP, known as A. 
    
    % Determine the FIP point which is not related to BC which is A. 
    % pdist = Matlab funtion
    %% The following algorithm is determined to only find A
    switch Max_indx
        case 1
            %longest distance between pos1 and 2 -> position 3 is A
            A = FIPs(3,:);
            % B and C arbitrary, will calculate later
            B = FIPs(2,:); 
            C = FIPs(1,:); 
        case 2
            %longest distance between pos1 and 3 -> position 2 is A
            A = FIPs(2,:);
            B = FIPs(3,:);
            C = FIPs(1,:); 
        case 3
            %longest distance between pos2 and 3 -> position 1 is A
            A = FIPs(1,:);
            B = FIPs(2,:); 
            C = FIPs(3,:);
    end
    
    A_point = A;

    %% Find the lower left and top right, B and C. 
    % vectors between points
    AB = B-A;
    AC = C-A;
    %BC = C-B;
    %algorithm is from http://geomalgorithms.com/vector_products.html
    k = AB(1)*AC(2) - AB(2)*AC(1);
        
    % AB _|_ AC > 0, AC left of AB => C is topRight. Otherwise the
    % opposite. 
    if k > 0
        C_point = C;
        B_point = B;
    else
        B_point = C;
        C_point = B;
    end
    
    
    
    
    
    
    
    

end