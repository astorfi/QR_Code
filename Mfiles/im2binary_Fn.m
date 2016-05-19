%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function bin = im2binary_Fn(img)
%
% Get an image and transform it to a binary image (Zero and one)
%Image Processing final project-University of Maryland, College Park
%
% Amirsina Torfi
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Im_binary = im2binary_Fn(img,Thresh)

% Find the gray threshold level
if isempty(Thresh)
    Th = graythresh(img);
else
    Th = graythresh(img)-Thresh;
end


% Make the image binary using the level
Out = im2bw(img,Th);

Im_binary=Out;