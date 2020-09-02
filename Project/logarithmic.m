function l = logarithmic(g)
    g = im2double(g);
    c=3;
    [M,N]=size(g);
    for x = 1:M
        for y = 1:N
            m=double(g(x,y));
            l(x,y)=c.*log10(1+m); 
        end
    end
end
