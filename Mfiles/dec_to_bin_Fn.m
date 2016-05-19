function Bin_Str=dec_to_bin_Fn(Data_decode)     % Decimal numbers should transform to a binary matrix
Bin_Str=[];
for i=1:length(Data_decode)
   b=[];Rem=Data_decode(i);
   for j=1:8
       a=mod(Rem,2);
       b=[a b];
       Rem=Rem-a;
       Rem=Rem/2;
   end
   Bin_Str=[Bin_Str b];
    
    %     bin=str2mat(dec2bin(Data_decode(i)));

    %     bin=[zeros(1,8-length(bin)) bin];
%     bin=[bin(1) bin(2) bin(3) bin(4) bin(5) bin(6) bin(7) bin(8)];
    %Bin_Str=[Bin_Str bin];

end

