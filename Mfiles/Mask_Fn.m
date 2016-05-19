%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing %%%%%%%%%%%%%%%%%
%%% function message = decode_ADVANCED_QR(QR)
% Inputs :
           % Imase: Input is the QR exact matrix(for example which is 41by41 for version6)
           % Mask_pat_Num : the number of mask pattern which was extracted
           % from the format string bits in the previous sections

           
% Outputs :
           %  Mask_pattern : The mask format


function [ Mask_pattern ] = Mask_Fn( Image,Mask_pat_Num )
global module
referenceIm = false(module);
referenceIm(1:8,1:8) = 1;       % left-upper corner
referenceIm(module-7:module, 1:8) = 1;    % left-down corner
referenceIm(1:8, module-7:module) = 1;    % right-upper corner
if module>21
referenceIm(module-8:module-4,module-8:module-4) = 1;   % small FIP
end
 referenceIm(7,9:module-8) = 1;      % Horizontal Timing
 referenceIm(9:module-8,7) = 1;      % Vertical Timing
referenceIm(module-7,9) = 1;        % Dark module
 % Format Information Area
referenceIm(9,1:9) = 1;       
referenceIm(1:9,9) = 1;
referenceIm(9,module-7:module) = 1;
referenceIm(module-7:module,9) = 1;
Image(referenceIm) = nan;
out = nan(size(Image,1),size(Image,2));
%% masking pattern for different mask pattern numbers
% row i and column j means location (i-1,j-1) by difinition of masking
switch Mask_pat_Num
    case 0
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod(i-1+j-1,2)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 1
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod(i-1,2)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 2
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod(j-1,3)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 3
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod(i-1+j-1,3)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 4
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod((floor((i-1)/2)+floor((j-1)/3)),2)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 5
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if (mod((i-1)*(j-1),2)+mod((i-1)*(j-1),3))==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 6
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod((mod((i-1)*(j-1),2)+mod((i-1)*(j-1),3)),2)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end
    case 7
        for i=1:size(Image,1)
            for j=1:size(Image,2)
                if mod((mod((i-1)+(j-1),2)+mod((i-1)*(j-1),3)),2)==0
                    out(i,j)= mod(Image(i,j)+1,2);
                end
            end
        end        
end

Mask_pattern=out;      % New entries are determined and fix entries clarify by nan

end


