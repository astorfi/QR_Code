function [ Data_Strm ] = Data_Str_Ext_Fn( str,Char_Size,Mode,Error_Recov_Type,module )

switch Mode
    case 'Numeric'
        a=(Char_Size-mod(Char_Size,3))/3;
        Data_Strm=str(1,15:15+(10*a-1));
        if mod(Char_Size,3)==1
            Data_Strm2=str(1,15+10*a:18+10*a);      % If there is a 1-digit at the end there should be 4-bit for its representation
            Data_Strm=[Data_Strm Data_Strm2];
        elseif mod(Char_Size,3)==2
            Data_Strm2=str(1,15+10*a:21+10*a);      % If there is a 2-digit at the end there should be 7-bit
            Data_Strm=[Data_Strm Data_Strm2];
        else
            Data_Strm2=[];
        end
        
        
        
    case 'Alphanumeric'
        if mod(Char_Size,2)==0
            Data_Strm=str(1,14:14+(11*(Char_Size/2)-1));
        else
            Data_Strm=str(1,14:14+(11*((Char_Size-1)/2)-1)+6);
        end
        
    case 'Byte'
        
        Data_Strm=str(1,13:13+(8*Char_Size-1));
        
    case 'Kanji'        % No definition for Kanji
        errordlg('Kanji!!!')
        
    case 'ECI'
        errordlg('ECI!!!');
end


end





