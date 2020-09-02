function t = pwr_law_transformation(f)
    f = im2double(f);
    [m n]=size(f);
    c = 1;
    y=1.2;

    for i=1:m
        for j=1:n
            t(i,j)=c*(f(i,j)^y);
        end
    end
end
