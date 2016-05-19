# QR Code Pattern Recognition and Message Extraction

The goal of this project is to successfully detect and reconstruct perfect QR-code pattern
and then decode and extract the message and information within. Usually the QR-code
images are corrupted, Blurred or at least rotated which make the pattern recognition
harder than simple scenarios. In this situation robust algorithms can effectively recognize
specic patterns in the image and reconstruct the main matrix of quick response code.
In the first part of this project the implemented software, which is developed using
MATLAB, successfully recognize the main QR pattern and then extract the QR-Matrix.
Then by using decoding techniques, the message is extracted from the QR-code. The
QR-matrix might be corrupted, i.e. we probably lost some amount of information.
According to this scenario, QR-codes are made by Error-Correction Coding which help us
through the decoding process. In order to demonstration of precision and authentication
of software, different test images have been tested. Note that this project is restricted 
to QR codes version-1 through version-6.
