%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function locationFIPs = find_Probable_FIPs_Fn(img)
%
% Given a image that is processed and binary, this function searches and
% stores the location of a possible FIP candidate. 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function locationFIPs = find_Probable_FIPs_Fn(img)
    % initiate some variabels to be used
    numberOfFIPS = 0;
    locationFIPs = [0 0];
    [row_Num, ~] = size(img);
    
    %% search the row for a FIP candidate
    for row = 1 : row_Num
        Tr_Line = img(row,:); % pick out the entire row
        
        % calculate the appearence of the modules in row.
        length_modules = Mod_Tr_Fn(Tr_Line);
        
        pixelPosCol = 1; %      Check sequence to find approbriate pattern similar to Finder Patterns
        for i = 1:length(length_modules)-4  
            vectorFIP = length_modules(i:i+4);
            [isFIP, ~] = checkRatio_Fn(vectorFIP, [1 1 3 1 1]);
            
            % The ratio is correct and the first value is "black", Since it might be the case we should search in that column
            if(isFIP &&  img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorFIP)/2); % Specific column for search

                pixelPosRow=1; %  Initial point
                
                Tr_col = Mod_Tr_Fn(img(:,col));
                % search trough the column and see if the FIP pattern is
                % found, if at almost the same row, store as a candidate.
                for j = 1:length(Tr_col)-4
                    vector_row_FIP = Tr_col(j:j+4);
                    [rowFIP, ~] =  checkRatio_Fn(vector_row_FIP, [1 1 3 1 1]);
                    
                    if(rowFIP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_FIP)/2;
                        if (abs(rows-row) <= 8) %allow a error(Number 8 is error and can be modified by the application)    % Default is if (abs(rows-row) <= 8) %allow an error for tollerance(Bif images need that)
                            numberOfFIPS = numberOfFIPS + 1;
                            locationFIPs = [locationFIPs; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + Tr_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i);
        end

    end
    
    % since we allocated the first position to [0 0], just remove this. 
    locationFIPs = locationFIPs(2:end,:);
      
       
end