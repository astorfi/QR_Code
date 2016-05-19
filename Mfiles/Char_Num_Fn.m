% This sub function only workds for version 1-9
function [ Num ] = Char_Num_Fn( str,Mode,Error_Recov_Type,module )

% if (module==29 && Error_Recov_Type=='Q')        % According to interleaving pattern
%     a=str(1,1:8);
%     b=str(1,17:24);
%     First_sixteen=[a b];
% elseif (module==29 && Error_Recov_Type=='H')
%     a=str(1,1:8);
%     b=str(1,17:24);
%     First_sixteen=[a b];
% else
     First_sixteen=str(1,1:16);
% end


switch Mode
    case 'Numeric'
        Bit_Num=First_sixteen(1,5:14);
        st=num2str(Bit_Num);
        Num=bin2dec(st);
        
    case 'Alphanumeric'
        Bit_Num=First_sixteen(1,5:13);
        st=num2str(Bit_Num);
        Num=bin2dec(st);
        
    case 'Byte'
        Bit_Num=First_sixteen(1,5:12);
        st=num2str(Bit_Num);
        Num=bin2dec(st);
        
    case 'Kanji'
        errordlg('Kanji!!!')
        
    case 'ECI'
        errordlg('ECI!!!');
end


end

