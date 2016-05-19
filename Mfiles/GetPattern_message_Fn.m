%% Digital Image and Video Processing(University of Maryland College Park) - Final Porject(Spring 2015)
% Amirsina Torfi(amirsina.torfi@gmail.com)

%%% function [Msg,Large_QR] = GetPattern_message_Fn(Im)

% Some functions called by this main function:
%     im2binary_Fn.m
%     find_Probable_FIPs_Fn.m
%     findFIP_Order_Fn.m
%     findAP_Fn.m
%     Geo_Trans_Fn.m
%     decode_ADVANCED_QR.m


% Inputs :
           % Im: Main image which might be corrupted, blurred , ets...
           
% Outputs :
           % Msg: QR-code message
           % Large_QR: Reconstructed QR-Code image in a full image
           % dedicated only to QR-pattern (Quite Zone has not been added because it is not neccessary but it has been calculated in the "Geo_Trans_Fn" subfunction)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Msg,Large_QR] = GetPattern_message_Fn(Im,AP_h_check)
global module

%% ====================== Part 1: Preprocessing ==============================
% Make image binary
img = im2binary_Fn(Im,[]);
img = medfilt2(img);      % Uncomment if not neccessary(Used for reducing the salt and pepper noise)


%% ====================== Part 2: Pattern Recognition ==============================
% find Finder patterns in the image
FIPs = find_Probable_FIPs_Fn(img);
FIP_L = findFIP_Order_Fn(FIPs);

% find AP(Alignment pattern) point in the image
 AP_Loc = findAP_Fn(FIP_L,img,AP_h_check);
 if isempty(AP_Loc)
    warndlg('No Alignment Pattern can be find','!! Warning !!')
end

% Transform the image and reconstruct the QR pattern
[~,newim] = Geo_Trans_Fn(Im, FIP_L, AP_Loc);

% Resize image for better display
Main_QR_Matrix = imresize(newim, [module module], 'nearest');
Large_QR = imresize(Main_QR_Matrix, [10*module 10*module], 'nearest');


% Read the QR-code message
figure;
subplot(1,2,1)
imshow(Im);
title('Main Image')
subplot(1,2,2)
imshow(Large_QR)
title('Reconstructed QR-code')

%% ====================== Part 3: Decoding and Message Extraction ==============================
message = decode_ADVANCED_QR(double(Main_QR_Matrix));
h = msgbox(message,'Output Message');
Msg=message;
