function f = Filtering(img)
    f = img;
    I = double(f); 
    for i=1:size(I,1)-2
        for j=1:size(I,2)-2
            Average = round((I(i,j)+I(i+1,j)+I(i+2,j)+I(i,j+1)+I(i+1,j+1)+I(i+2,j+1)+I(i,j+2)+I(i+1,j+2)+I(i+2,j+2))/9);
            f(i,j) = Average;
        end
    end
end
