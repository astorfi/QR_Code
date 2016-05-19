%% Digital Image and Video Processing(University of Maryland College Park) - Final Porject(Spring 2015)
% Developer: Amirsina Torfi(amirsina.torfi@gmail.com)
% 
%  This file is the main file for executing the software. This software get
%  and image and extract and reconstruct the QR-code within. After Pattern
%  Recognition the software decode the message within the QR-code and
%  display it.
%
% This software is solely for QR-codes version 1 through 6.
%
% Some functions called by this main function:
%     GetPattern_message_Fn.m
%
% Inputs:
%          module: QR-code module which cannot be automatically detected by software.
%          Im: Input image
%          AP_h_check: Authorization for horizontally check the alignment
%          pattern(See documentation)
% Outputs:
%          Msg: Message within the QR-code
%          QR: QR-code pattern

%% ====================== Part 1: Basic inputs ==============================
clc
clear all
close all
global module       % Global definition for being used in other subfunctions.
% Input dialog
prompt = {'Please input the version:'};
dlg_title = 'Version';
num_lines = 1;
def = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
[version, ~] = str2num(answer{1});
module=4*version+17;    % Number of modules(General formula=4*(Version Number)+17)  

Im = imread('testimage/UMD/Qr-3a.jpg');     % Input image.
tic     % Start the timing process

%% ====================== Part 2: Horizontal check ratio request for validating Alignment pattern ===========
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

%% ====================== Part 3: Recalling the main function for pattern recognition and message extraction =====
[Msg,QR] = GetPattern_message_Fn(Im,AP_h_check);
% End the timing process
toc
