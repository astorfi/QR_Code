%%% Same as chack diag but from another direction

function answer = check_diag2_Fn(AP,range,img)
Vec=[];
for i=-range:1:range
    Vec=[Vec img(floor(AP(1,1))+i,floor(AP(1,2))-i)];
end
length_modules = Mod_Tr_Fn(Vec);
c=1;
pos=[];
for k = 1:length(length_modules)-2
    vectorAP = length_modules(k:k+2);
    [isAP, ~] = checkRatio_Less_Fn(vectorAP, [1 1 1]);
    if isAP
        pos(c) = sum(length_modules(1:k))+(floor(length_modules(1,k+1)))/2;
        c=c+1;
    end
end
pos(pos>1+range)=[];
pos(pos<-1+range)=[];
pos
range

if (~isempty(pos))
    answer=1;
else
    answer=[];
end

end



