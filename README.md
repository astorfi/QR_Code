# QR Code Pattern Recognition and Message Extraction

## Introduction
The goal of this project is to successfully detect and reconstruct perfect QR-code pattern
and then decode and extract the message and information within. Usually the QR-code
images are corrupted, Blurred or at least rotated which make the pattern recognition
harder than simple scenarios. In this situation robust algorithms can effectively recognize
specic patterns in the image and reconstruct the main matrix of quick response code.
The project has two main part:
* In the first part of this project the implemented software, which is developed using
MATLAB, successfully recognize the main QR pattern and then extract the QR-Matrix.
* Then by using decoding techniques, the message is extracted from the QR-code. The
QR-matrix might be corrupted, i.e. we probably lost some amount of information. 
According to this scenario, QR-codes are made by Error-Correction Coding which help us
through the decoding process. 

## Running the Code and Considerations

Run **Mfiles/MAIN.m** file. Two things needs to be considered:
* The version of the QR-Code should be known and input by the user although brute-force search can be done by the user too. In other word if the user does not know the version of QR-Code, he/she has to test all the six versions supported by the code by inputing the version number.
* The other important thing is that, the path of the input image has to be determined by the user.

The following code of the **MAIN.m** file demonstrates the two aforementioend matter.

'''
prompt = {'Please input the version:'};
dlg_title = 'Version';
num_lines = 1;
def = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
[version, ~] = str2num(answer{1});
module=4*version+17;    % Number of modules(General formula=4*(Version Number)+17)  
Im = imread('testimage/UMD/Qr-3a.jpg');     % Input image.
'''

## Test and Limitations
In order to demonstration of precision and authentication
of software, different test images have been tested. Note that this project is restricted 
to QR codes version-1 through version-6.
