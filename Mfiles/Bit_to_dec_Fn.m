% Simply changing the binary sequence to decimal
function [ dec_str ] = Bit_to_dec_Fn( str )
dec_st=[];
for i=1:length(str)/8       % How do we know it is devisible by 8?? answer: QR-code encoding standarnd
    seq=str(1,8*(i-1)+1:8*i);
    dec_st=[dec_st bin2dec(num2str(seq))];
end
dec_str=dec_st;

