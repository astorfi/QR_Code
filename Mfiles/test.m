clc
clear all
close all
global module
%% Input dialog
prompt = {'Please input the version:'};
dlg_title = 'Version';
num_lines = 1;
def = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
[version, ~] = str2num(answer{1});
% Number of modules(version2=25 version3=29 version6=41,..., General formula=4*(Version Number)+17) 
module=4*version+17;     
tic     % Start the timing process

I = imread('testimage/UMD/Qr-3a.jpg');
%% Horizontal check ratio request for validating Alignment pattern
% Construct a questdlg with three options
choice = questdlg('Would you prefer horizontal check_ratio for validating Alignment Pattern?', ...
	'AP Validation,Horizontal Check', ...
	'Yes','No','Yes');
% Handle response
switch choice
    case 'Yes'

        AP_h_check = 1;
    case 'No'

        AP_h_check = 0;

end

%% Main part
[Msg,QR] = GetPattern_message_Fn(I,AP_h_check);
%% Ploting the main image

toc
