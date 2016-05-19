function [ Final_Dec ] = DecNum_Get_Fn( Data_str , Mode)

switch Mode
    case 'Numeric'
        
        Final_Dec1=[];
        for i=1:(length(Data_str)-mod(length(Data_str),10))/10
            A=Data_str(1,1+10*(i-1):10+10*(i-1));
            A1=num2str(A);
            A=bin2dec(A1);
            Final_Dec1=[Final_Dec1 A];
        end
        A=Data_str(1,length(Data_str)-mod(length(Data_str),10)+1:end);      % last number
        A1=num2str(A);
        A=bin2dec(A1);
        Final_Dec=[Final_Dec1 A];

%         Final_Dec=Zer_Pad_Seq(Final_Dec1)    % adding zero before two-digit numbers for representation
        
    case 'Byte'
        
        Final_Dec=[];
        for i=1:length(Data_str)/8
            A=Data_str(1,1+8*(i-1):8+8*(i-1));
            A1=num2str(A);
            A=bin2dec(A1);
            Final_Dec=[Final_Dec A];
        end
        
    case 'Alphanumeric'
        
        Final_Dec=[];
        if mod(length(Data_str),11)==0
            for i=1:length(Data_str)/11
                A=Data_str(1,1+11*(i-1):11+11*(i-1));
                A1=num2str(A);
                A=bin2dec(A1);
                Final_Dec=[Final_Dec A];
            end
        else
            for i=1:(length(Data_str)-mod(length(Data_str),11))/11
                A=Data_str(1,1+11*(i-1):11+11*(i-1));
                A1=num2str(A);
                A=bin2dec(A1);
                Final_Dec=[Final_Dec A];
            end
            
            A=Data_str(1,length(Data_str)-mod(length(Data_str),11)+1:length(Data_str)-mod(length(Data_str),11)+6);
            A1=num2str(A);
            A=bin2dec(A1);
            Final_Dec=[Final_Dec A];
            
        end

end

