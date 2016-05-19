%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function FIPs = findFIPs_Fn(FIPCandidates)
%
%Function that will take in all the possible FIP locations and return only
%three locations to the "real" FIPs. Will return an empty matrix if the FIP
%candidates is smaller than 3, something gone wrong then in searching for
%the FIPs. Will return the FIPs in know order, so the output is 
%FIPs = [lowerLeft; topLeft; topRight]. 
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FIPs = findFIPs_Fn(FIPCandidates)
global module
    if( length(FIPCandidates) < 3 )
        % something gone wrong! just return empty matrix
        FIPs = [ ];
    else 
        % use k-means to find three clusters as the thrsee fips
        [idx, centerPoints] = kmeans(FIPCandidates,3,'Distance','cityblock',...
                           'Replicates',5);
        
        % just varify it we have some outliner that will give a centerpoint
        % that is to far away. Pick a real point of the FIPCandidates that
        % has the smalles distance to the calculated centerpoint of the
        % k-means. Does this for every cluster.
        for i=1:3
            calculatedPos = centerPoints(i,:);
            realLocation = FIPCandidates(idx==i,:);
            [~,index] =min( pdist2( calculatedPos, realLocation, 'euclidean') );
            FIPs(i,:)=realLocation(index,:); % pick out the FIP that had the smallest distane
        end
        
        % Find the right order of the FIPs
        [lowerLeft, topLeft, topRight] = getRightOrderOfFIPs(FIPs);
        rightOrder = [lowerLeft; topLeft; topRight];
        
        FIPs=rightOrder;
    end

end