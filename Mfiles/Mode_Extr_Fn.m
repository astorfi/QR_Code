function [ Mode ] = Mode_Extr_Fn( st )

Md1= [1;
2;
3;
4;
5];

Md2= [0 0 0 1;
0 0 1 0;
0 1 0 0;
1 0 0 0;
0 1 1 1];

for k=1:size(Md2,1)
    m=0;
    for j=1:size(Md2,2)
        if Md2(k,j) == st(1,j)
            m=m+1;
        end
    end
    if m == 4
        h2=k;
    end
end

Mode=Md1(h2,1);
switch Mode
    case 1
        Mode = 'Numeric';

    case 2
        Mode = 'Alphanumeric';
   
    case 3
        Mode = 'Byte';

    case 4
        Mode = 'Kanji';

    case 5
        Mode = 'ECI';

end

