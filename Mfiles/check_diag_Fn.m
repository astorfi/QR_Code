%%%%%%%%%%%%% Amirsina Torfi %%%%%%%%%%%%%%%%%%%%
%%%%%%% This function perform a diagonal search for AP pattern %%%%%%%%%%%


function answer = check_diag_Fn(AP,range,img)
Vec=[];
for i=-range:1:range
    Vec=[Vec img(AP(1,1)+i,AP(1,2)+i)];
end
length_modules = Mod_Tr_Fn(Vec);
c=1;
pos=[];
for k = 1:length(length_modules)-2
    row=sum(length_modules(1,1:k-1))+1;
    vectorAP = length_modules(k:k+2);
    [isAP, ~] = checkRatio_Fn(vectorAP, [1 1 1]);
    if (isAP && img(AP(1,1)-range+row-1,AP(1,2)-range+row-1)==1)
        pos(c) = sum(length_modules(1,1:k))+(length_modules(1,k+1))/2;
        c=c+1;
    end
end

%%%abs{pos-(range+1)}>m   % error
m=1; % error
pos(pos>m+1+range)=[];
pos(pos<-m+range+1)=[];


if ~isempty(pos)
    answer=1;
else
    answer=[];
end

end



