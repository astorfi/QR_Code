%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing %%%%%%%%%%%%%%%%%
%%% function [ STR,Block_num ,Data_codew_Perb_Num] = Stream_reorder_ADVANCED_Fn( str,Error_Recov_Type,module )
% Inputs :
           % str: decimal sequence of matrix which contains data and error
                  % correction codewords
           % Error_Recov_Type: Error correction level
           % module: Number of module which is used for version detection

           
% Outputs :
           % STR: matrix which any row of it concern with a specific block
                  % of data followed by its specific error correction sequence
           % Block_num: number of blocks
           % Data_codew_Perb_Num: number of data codewords per each block in
                                %interleaving
           

function [ STR,Block_num ,Data_codew_Perb_Num] = Stream_reorder_ADVANCED_Fn( str,Error_Recov_Type,module )

% module % total data codewords % ECC code word per block % number of block
% number of data code word per block
Tab1=[21	19	7	1	19
    21	16	10	1	16
    21	13	13	1	13
    21	9	17	1	9
    25	34	10	1	34
    25	28	16	1	28
    25	22	22	1	22
    25	16	28	1	16
    29	55	15	1	55
    29	44	26	1	44
    29	34	18	2	17
    29	26	22	2	13
    33	80	20	1	80
    33	64	18	2	32
    33	48	26	2	24
    33	36	16	4	9
    37	108	26	1	108
    37	86	24	2	43
    41	136	18	2	68
    41	108	16	4	27
    41	76	24	4	19
    41	60	28	4	15];
Tab2=['L'
    'M'
    'Q'
    'H'
    'L'
    'M'
    'Q'
    'H'
    'L'
    'M'
    'Q'
    'H'
    'L'
    'M'
    'Q'
    'H'
    'L'
    'M'
    'L'
    'M'
    'Q'
    'H'];

%% Reshaping data eccording to interleaving standards(Very special cases are 5-Q and 5-H!!!)
if (module==37 && Error_Recov_Type=='Q')        % According to interleaving pattern
    
    Block_num=4;
    str1=[str(1:Block_num*15) 0 0 str(Block_num*15+1:length(str))];     % put two zero because the first two blocks in group1 have 1 number less than blocks in group2 (15 and 16 is the lengths of blocks in group1 and 2 respectively)
    STR1=reshape(str1,Block_num,[]);
    STR = STR1;
    Data_codew_Perb_Num=15;
    
elseif (module==37 && Error_Recov_Type=='H')        % According to interleaving pattern
    
    Block_num=4;
    str1=[str(1:Block_num*11) 0 0 str(Block_num*11+1:length(str))];
    STR1=reshape(str1,Block_num,[]);
    STR = STR1;
    Data_codew_Perb_Num=11;
    
    
else        % Other versions and error correction levels
    
    a=find(Tab1==module);
    b=find(Tab2==Error_Recov_Type);
    for i=1:length(a)
        FF=find(b==a(i),1);
        if ~isempty(FF)
            Row=b(FF);
        end
        
    end
    Data_codew_Perb_Num=Tab1(Row,5);
    Block_num=Tab1(Row,4);
    STR=reshape(str,Block_num,[]);
end



end



