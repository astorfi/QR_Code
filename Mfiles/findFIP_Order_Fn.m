%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function FIPs = findFIP_Order_Fn(FIP)
%
%This function cosiders all possible FIP probable locations and return
%three locations to the "real" FIPs.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FIPs = findFIP_Order_Fn(FIP)

    if( length(FIP) > 2 )

        % Kmeans select three finder pattern as a match... and finding
        % three cluster
        [idx, Points] = kmeans(FIP,3,'Distance','cityblock',...
                           'Replicates',5)  ;    % idx determine which point is belongs to which cluster
        
        %% In this part the location of 3 finder pattern would be gained
        for i=1:3       % Compare each FIP in a cluster with that specific cluster center
            Pos = Points(i,:);
            Determnd_Location = FIP(idx==i,:);       % Location is belons to the FIP with index==idx which has been finded from the kmeans function
            [~,index] =min( pdist2( Pos, Determnd_Location, 'euclidean') );
            FIPs(i,:)=Determnd_Location(index,:); % pick out the FIP that had the smallest distane
        end
        %% Find the right order of the FIPs
            % A-------C
            % |    _/
            % |  _/
            % |_/
            % B/
        [B_point, A_point, C_point] = get_Correct_Order_FIPs_Fn(FIPs);      % Another sub-function
        Correct_Order = [B_point; A_point; C_point];
        
        FIPs=Correct_Order;
    else
        % Demonstrating error if there is not 3-finder pattern
        error(' The Simulation cannot find three finder pattern or the geometric trasformation is wrong!!!!')
    
    end

end