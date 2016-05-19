%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing %%%%%%%%%%%%%%%%%
%%% function [ str_decode ] = Reed_SLM_Decoder( msg,ECC )
% This function is Reed-Solomon decoder which separately receive part of
% data and parity sequence and decode it


% Inputs :
           % msg: The data related part in the block
           % ECC: The error correction part in the block

           
% Outputs :
           % Data_decode: decoded decimal sequence
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ str_decode ] = Reed_SLM_Decoder( msg,ECC )

m = 8; % Number of bits in each symbol
n = 2^m-1; k = n-length(ECC); % Codeword length and message length
%msg_recons=[ zeros(1,k-length(msg)) msg]';     % Used for reed-solomon
                                                   %encoding
% Simplest syntax for encoding
    %hEnc = comm.RSEncoder(n,k);
hDec = comm.RSDecoder(n,k);
    %c1 = step(hEnc, msg);
    %d1 = step(hDec, c1);


%% Vary the generator polynomial for the code.
%release(hEnc);
release(hDec)
    %hEnc.GeneratorPolynomialSource = 'Property';
hDec.GeneratorPolynomialSource = 'Property';
    %hEnc.GeneratorPolynomial       = rsgenpoly(n,k,[],0);
hDec.GeneratorPolynomial       = rsgenpoly(n,k,[],0);
     %c2 = step(hEnc, msg_recons)
c2 = [zeros(1,n-length(msg)-length(ECC)) msg ECC]';     %n-length(msg)-length(ECC) is for object command and is neccessary
                                                        % c2 should be
                                                        % column vector
d2 = step(hDec, c2);

d=d2(size(d2,1)-length(msg)+1:size(d2,1),1);
d=d';
str_decode=d;
end

