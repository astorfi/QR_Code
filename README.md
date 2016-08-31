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

```
prompt = {'Please input the version:'};
dlg_title = 'Version';
num_lines = 1;
def = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
[version, ~] = str2num(answer{1});
module=4*version+17;    % Number of modules(General formula=4*(Version Number)+17)  
Im = imread('path_to_image');     % Input image.
```
## Reliability

The reliability is based on two important consideration:

* The first one is that whether the image processing part can extract the correct QR pattern or not?
* The second one is that is we have the correct pattern of the QR code, whether we can decode it or not?

### Error Correction Reliability
The second item related to the number of errors which Reed-Solomon decoder should correct. If the error is more than the maximum ability of the error correction then the message cannot be correctly and fully decoded. Since this part is not the main goal of this project/course so we don't go deep any further in this area.

### QR Code Pattern Recognition Ability

There is different scenarios and different approaches to overcome the deficiencies. We investigate them from the easy to the worst case scenario.

#### Three Finder Pattern and one Alignment Pattern

Suppose that we have a clear image and straight point of view. This is the easiest scenario. We believe that the software can easily detect the finder patterns and alignment pattern and the QR code reconstruction would be easy. In other scenarios even if the image is blurred or damaged, if we can find this 4-points, then we can perfectly reconstruct the QR code.

#### Limitation

The caveat is that what if the simulation finds a wrong alignment pattern or finder patter? The answer is according to the characteristics of the finder patter it is very unlikely to find a wrong finder pattern. The software has been tested for wide variety of images. The problem is that it is likely for software to find a point as the Alignment Pattern while it is not!! The reason that we have add another diagonal ration search for AP candidates is to prevent this phenomenon and by testing different test images we conclude that the developed software is reliable to that even.

#### Three Finder Pattern and no Alignment Pattern

Sometimes the software cannot find the AP because there might be no AP in a damaged image or there is but the software cannot be find the Alignment Pattern. The former has no solution for finding AP but for the later we can allow more error in searching for the alignment pattern. This ability is defined in the software. 

#### Limitation

The caveat is that allowing more error might lead to finding an Alignment Pattern which is not the correct one. The final solution for that which prevent this issue is that if the software cannot detect AP then ignore it and use the last corner of the QR-Code as the fourth point for perspective transformation. But the previous algorithm that we developed for this task was not very precise because if the image is not from straight point of view the if the looking angle is far from 90 even by 20 degree, then the software fail to find the fourth corner of the QR-Code\footnote{Fourth corner refers to the corner which is not connected to any of three finder patterns} pattern. In better words it finds something which is not the correct one. The last algorithm that we implemented for this issue is to find two candidates for the fourth corner and using the average. According to the test images that we used for this algorithm, it is more efficient than the previous one.

#### Less Than Three Finder Pattern

If the simulation cannot find more than three finder pattern then it is very difficult to tackle this problem. It may happen in very rare scenarios which the image is very blurred and almost the pattern cannot be scene. The solution is to use different thresholding in order to find and locate the finder patterns and separators. In this scenario we try the previous approach for finding the fourth corner of QR code and try to reconstruct the pattern.

#### Advantage of Algorithm for Finding the Fourth Corner

The advantage of finding the fourth corner is that is lots of the scenarios we can have a straight image from the pattern whether blurred and noisy or not. Using this method we don't need to have the Alignment Pattern location. It might be less reliable but if there is not any other choice it can be applied.

## Limitation of Decoding

The simulation sometimes fails to decode the version 5-Q and 5-H QR code because of the more complex interleaving pattern of the data and error correction code-words. The author is working on modifying the software to successfully decode 5-Q and 5-H QR codes.

## Future work

Since this project is only considering the version 1 through 6 then an interesting extend to this project can be modifying software for having correct results for higher versions.

Since the version number should be enter by the software executive man another interesting extend can be developing a software to automatically detect the version of QR-Code which is a practical task and can be well implemented in real life applications.

The other issue to finding the alignment pattern. The software should be adapted such that if there is any Alignment pattern it has the reliability to locate that. Basically our software do the job quite well but testing its reliability in deeper sense can improve its efficiency.


## Test
In order to demonstration of precision and authentication
of software, different test images have been tested. Note that this project is restricted 
to QR codes version-1 through version-6.
