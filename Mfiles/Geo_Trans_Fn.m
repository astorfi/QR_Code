%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing(Spring 2015) %%%%%%%%%%%%%%%%%
%%% function [transformed,newim] = Geo_Trans_Fn(Im, fips, ap)
% Inputs :
% Im: Main image which might be corrupted, blurred , ets...
% fips: Finder patterns locations
% ap: Alignment pattern location

% Outputs :
% newim: only QR-code pattern
% transformed: "QR-code + Quite zone"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [transformed,newim] = Geo_Trans_Fn(Im, fips, ap)

% The finder patterns of the distorted image
global module

% A-------C
% |    _/
% |  _P/
% |_/
% B/

% Receive the vectors between the fips
A = fips(2,:);
B = fips(1,:);
C = fips(3,:);

AC = C-A;
AB = B-A;
P=(B+C)/2;
% Unit normal vector calculation
normAC = unit_v_Fn(A,C);
normAB = unit_v_Fn(A,B);

% Find distance between the finder patterns
dist_1 = sqrt(AC(1)^2 + AC(2)^2);
dist_2 = sqrt(AB(1)^2 + AB(2)^2);

% Find the correct values for the transformed fip
% the length between the fips is based on the longest distance
% between the fips in the distorted image
dist_max = max(dist_1, dist_2);     % Difine as the new scale for QR-code reconstruction and is identical in both sides because QR-code pattern is square
cell_width_1=dist_1/(module-7);
cell_width_2=dist_2/(module-7);
normCA=unit_v_Fn(C,A);
normBA=unit_v_Fn(B,A);

%% Extra Points for better reflection
%% Four courners of A
% A11-------A12
% |    _/
% |  _/
% |_/
% A21/-------A22

A11 = normCA*((module/2))*cell_width_1 + normBA*((module/2))*cell_width_2 + P;
A22 = normCA*((module/2)-7)*cell_width_1 + normBA*((module/2)-7)*cell_width_2 + P;
A12 = normAC*7*cell_width_1 + A11;
A21 = normAB*7*cell_width_2 + A11;

%% Four courners of B
% B11-------B12
% |    _/
% |  _/
% |_/
% B21/-------B22
B11 = normAB*(module-7)*cell_width_2 + A11;
B21 = normAB*(module-7)*cell_width_2 + A21;
B12 = normAB*(module-7)*cell_width_2 + A12;
B22 = normAB*(module-7)*cell_width_2 + A22;

%% Four courners of C
% C11-------C12
% |    _/
% |  _/
% |_/
% C21/-------C22

C11 = normAC*(module-7)*cell_width_1 + A11;
C21 = normAC*(module-7)*cell_width_2 + A21;
C12 = normAC*(module-7)*cell_width_2 + A12;
C22 = normAC*(module-7)*cell_width_2 + A22;


MM1= normAB*(module)*cell_width_2 + C12;        % The last corener
MM2= normAC*(module)*cell_width_1 + B21;        % The last corner alternative method
MM=(MM1+MM2)/2;
%% Based on the QR-code final patterns the following parameters are build
cell_width = dist_max/(module-7);
side = module*cell_width;
dist_min = 3.5*cell_width;
dist_fip = (module-3.5)*cell_width;
if size(ap)==[1 2]
    dist_ap = (module-6.5)*cell_width;
end

%% The correct coordinates for the QR code and necessarry for perspective transformation

size(ap,2)
if (~isempty(ap) && module>21)      % Versions-1 may not have align pattern
    moving_points = [fips(1,2) fips(1,1);            % B position
        fips(2,2) fips(2,1);            % A position
        fips(3,2) fips(3,1);        % C position
        ap(2) ap(1);            % AP location
        % Uncomment the following if you realize that
        % extra points are necessarry
        %                             MM1(1,2)  MM1(1,1);
        %                              A11(1,2) A11(1,1);
        %                              A12(1,2) A12(1,1);
        %                              A21(1,2) A21(1,1);
        %                               A22(1,2) A22(1,1);
        %                              B11(1,2) B11(1,1);
        %                               B12(1,2) B12(1,1);
        %                               B21(1,2) B21(1,1);
        %                              B22(1,2) B22(1,1);
        %                              C11(1,2) C11(1,1);
        %                              C12(1,2) C12(1,1);
        %                              C21(1,2) C21(1,1);
        %                              C22(1,2) C22(1,1);
        %                              AP11(1,2) AP11(1,1);
        %                              AP12(1,2) AP12(1,1);
        %                              AP21(1,2) AP21(1,1);
        %                              AP22(1,2) AP22(1,1);
        ];
    % The correct NEW coordinates for the QR code
else
    moving_points = [fips(1,2) fips(1,1);
        fips(2,2) fips(2,1);
        fips(3,2) fips(3,1);
        MM(1,2)  MM(1,1);
        A22(1,2) A22(1,1);
        B12(1,2) B12(1,1);
        C21(1,2) C21(1,1)];
end

if (~isempty(ap) && module>21)
    fixed_points = [dist_min dist_fip;
        dist_min dist_min;
        dist_fip dist_min;
        dist_ap dist_ap;
        %                              (module)*cell_width (module)*cell_width;
        %                              (7)*cell_width (7)*cell_width;
        %                              (7)*cell_width (module-7)*cell_width;
        %                              (module-7)*cell_width (7)*cell_width;
        ];
else
    fixed_points = [dist_min dist_fip;
        dist_min dist_min;
        dist_fip dist_min;
        (module)*cell_width (module)*cell_width;
        (7)*cell_width (7)*cell_width;
        (7)*cell_width (module-7)*cell_width;
        (module-7)*cell_width (7)*cell_width];
    
end

%% Find and perform the transformation for the image
tform = fitgeotrans(moving_points, fixed_points, 'projective');
newim_S = imwarp(Im, tform, 'linear');


%% This part will crop only the QR-code from the image

% Make the transformed image binary and find the finder patterns again
newim = im2binary_Fn(newim_S,[]);

% Finding new positions of Finder Patterns
FIPCandidates = find_Probable_FIPs_Fn(newim);
if( length(FIPCandidates) < 3 )
    newim = im2binary_Fn(newim_S,0.15);
    FIPCandidates = find_Probable_FIPs_Less_Fn(newim);
end
FIPLocations = findFIP_Order_Fn(FIPCandidates);

% Crop the image from the top left corner to a rectangle
% with the same size as the QR code

rect = [FIPLocations(2,2)-(dist_min) FIPLocations(2,1)-(dist_min) side side];
newim = imcrop(newim, rect);    % Refer to MATLAB help

%% Adding Quite Zone(See QR-code standard)
imwhite_QTZ=ones(round(side)+4*(round(dist_min)),round(side)+4*(round(dist_min)));
for i=1:size(newim,1)
    for j=1:size(newim,2)
        imwhite_QTZ(i+2*round(dist_min)-1,j+2*round(dist_min)-1)= newim(i,j);
    end
end
newim_QZ=imwhite_QTZ;
transformed = newim_QZ;