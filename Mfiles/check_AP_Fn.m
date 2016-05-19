function [ answer ] = check_AP_Fn( AP,img)


Intial = min([size(img,2)-AP(1,2),size(img,1)-AP(1,1),AP(1,1),AP(1,2)]);
answer1= check_diag_Fn(AP,floor(Intial/2-1),img);       % Diagonal search from top-left to down-right

if isempty(answer1)
    answer=[];
else
    answer=1;
end

end

