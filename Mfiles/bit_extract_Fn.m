%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing %%%%%%%%%%%%%%%%%
%%% function [ str ] = bit_extract_Fn( Im )
% Inputs :
           % Imase: Input is the QR exact matrix(for example which is 41by41 for version6

           
% Outputs :
                %  str : extracting the raw data from QR matrix
%    _
% | | |
% | | |
% | | | |
% |_| |_|
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ str ] = bit_extract_Fn( Im )

global module
%Scan_Num_Total=(module-1)/2;     % Total number of up/down scans(In each path we scan two column by zigzag order through the way)
Scan_Num_Right=((module-1)/2)-3;       % Scan the left of vertical timing pattern
Scan_Num_left=3;      % Scan the right of vertical timing pattern
V=[];
for S_Num=0:Scan_Num_Right-1
    V1=zig_Fn(Im(:,size(Im,2)-1-2*S_Num:size(Im,2)-2*S_Num),(-1)^(S_Num));
    V=[V V1];

end

for S_Num=0:Scan_Num_left-1
    V1=zig_Fn(Im(:,5-2*S_Num:6-2*S_Num),(-1)^(S_Num+1));
    V=[V V1];

end
str=V;
str(isnan(str))=[];
 str = mod(str+1,2);     % Black modules are binary 1 and white modules are binary 0 !!!!!

