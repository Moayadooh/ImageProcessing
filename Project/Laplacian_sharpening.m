function sh = Laplacian_sharpening(img)
    A=img;
    I1=A;
    I=zeros(size(A));
    F1=[0 1 0;
        1 -4 1;
        0 1 0];
    A=padarray(A,[1,1]);
    A=double(A);
    for i=1:size(A,1)-2
        for j=1:size(A,2)-2
            I(i,j)=sum(sum(F1.*A(i:i+2,j:j+2))); 
        end
    end
    I=uint8(I);
    sh = I1 - I;
end
