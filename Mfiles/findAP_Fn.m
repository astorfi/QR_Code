%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function AP = findAP(FIPs, img)
%
%A function that given an binary, processed image, and the calculated three
%FIP positions, search for the AP point and return the position for it.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function AP = findAP_Fn(FIPs, img,h_check)
global module
%% The order of the FIPs are [lowerLeft; topLeft; topRight];
% A-------C
% |    _/
% |  _/
% |_/
% B/

%% By usin linear algebra, find the point where in a perfect image, the AP (nearAP) point is located.


% just initiate som variables
locationAP = [0 0]; num = 0;

% pick out the FIPs and store as image above says
A = FIPs(2,:);
B = FIPs(1,:);
C = FIPs(3,:);
%% Considering part of the image which might be related to QR pattern
Rw=[A(1,1) B(1,1) C(1,1)];
Cl=[A(1,2) B(1,2) C(1,2)];
min_R=min(Rw);
max_R=max(Rw);
min_C=min(Cl);
max_C=max(Cl);
% img=img(min_R-min(min_R,(max_R-min_R)/2)+1:max_R+min((size(img,1)-max_R),(max_R-min_R)/2),min_C-min(min_C,(max_C-min_C)/2)+1:max_C+min((size(img,2)-max_C)));
ffff=size(img);
% figure;
% imshow(img)

% calculate the vectors between.
AC = C-A;
AB = B-A;
%% New Image
[Num_row, ~] = size(img);
% calculate one cell / module size, to move the AP closer to the right position
dist_1 = sqrt(AC(1)^2 + AC(2)^2);
dist_2 = sqrt(AB(1)^2 + AB(2)^2);
cell_width1 = dist_1/(module-7);
cell_width2 = dist_2/(module-7);

% normalize
normAC = AC/norm(AC);
normAB = AB/norm(AB);

% the module-7 is the distance between ex the middle A point to the first
% black module of the C.
nearAP = normAC*(module-9)*cell_width1 + normAB*(module-9)*cell_width2 + A ;

% to not search in the entire image for AP, know where it "should" be
% does not work properly
%     startRow = floor(nearAP(1)*0.5);
%     startCol = floor(nearAP(2)*0.5);

%% Find all the possible candidates for the AP
% start by searching the row
for row = 1 : Num_row
    scanline = img(row,:);
    %    for row = max(1,min_R-(max_R-min_R)) : min(size(img,1),max_R+(max_R-min_R))
    %         scanline = img(row,max(1,min_C-(max_C-min_C)) : min(size(img,2),max_C+(max_C-min_C)));
    
    % calculate the appearence of the modules in row.
    length_modules = Mod_Tr_Fn(scanline);
    
    pixelPosCol = 1; % to know which pixel position in column we are at
    % check the sequence if there is a possible AP, taking out every 3
    % element
    for i = 1:length(length_modules)-2
        vectorAP = length_modules(i:i+2);
        [isAP, ~] = checkRatio_Fn(vectorAP, [1 1 1]);
        
        % if the ratio is right and the first value is white)
        if(isAP &&  img(row, pixelPosCol)==1)
            col = pixelPosCol + floor(sum(vectorAP)/2); % search this column
            
            pixelPosRow=1;
            length_module_col = Mod_Tr_Fn(img(:,col));
            % search the column for ratio of AP, if almost same row as
            % above, store as AP candidate
            for j = 1:length(length_module_col)-2
                vector_row_AP = length_module_col(j:j+2);
                [rowAP, ~] =  checkRatio_Fn(vector_row_AP, [1 1 1]);
                if(rowAP && img(pixelPosRow,col)==1)
                    rows = pixelPosRow + sum(vector_row_AP)/2;
                    if (abs(rows-row) <= 1) % Small error tollerance
                        locationAP = [locationAP; [row col]];
                    end
                end
                pixelPosRow = pixelPosRow + length_module_col(j);
            end
            
        end
        pixelPosCol = pixelPosCol + length_modules(i);
    end
    
end
locationAP = locationAP(2:end,:);

% Find the most likely AP point.
% calculate the distance between the found AP candidates and the
% calculated nearAP in the beginning
if h_check==1
    APnew=[];
    for i=1:size(locationAP,1)
        AP=locationAP(i,:);
        [ answer ] = check_AP_Fn( AP,img);
        if ~isempty(answer)
            APnew=[APnew;AP];
        end
    end
    locationAP=APnew;
end


if ~isempty(locationAP)
    d = pdist2(locationAP, nearAP);
    [~, index] = min(d); % found the one with smallest distance
    
    % choose the point that had the smallest distane to the nearAP
    AP = locationAP(index,:);
    d2 = pdist2(locationAP, AP);
    I=find(d2<1.5);
    B1=[];
    B2=[];
    if size(I,1)>1
        for m=1:size(I,1)
            A=locationAP(I(m,1),:);
            B1=[B1 A(1,1)];
            B2=[B2 A(1,2)];
        end
        B1=sum(B1)/size(I,1);
        B2=sum(B2)/size(I,1);
        AP=[B1 B2];
    end
else
    AP=[];
end






end

