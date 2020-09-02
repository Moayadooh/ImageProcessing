function L = DCT(img)
    I1 = img;
    R = img(:,:,1);
    I = im2double(R);
    T = dctmtx(8);
    B = blkproc(I,[8 8],'P1*x*P2',T,T');
    mask = [1 1 1 1 0 0 0 0
            1 1 1 0 0 0 0 0
            1 1 0 0 0 0 0 0
            1 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0];
    B2 = blkproc(B,[8 8],'P1.*x',mask);
    I2 = blkproc(B2,[8 8],'P1*x*P2',T',T);

    G = img(:,:,2);
    I = im2double(G);
    T = dctmtx(8);
    B = blkproc(I,[8 8],'P1*x*P2',T,T');
    mask = [1 1 1 1 0 0 0 0
            1 1 1 0 0 0 0 0
            1 1 0 0 0 0 0 0
            1 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0];
    B2 = blkproc(B,[8 8],'P1.*x',mask);
    I3 = blkproc(B2,[8 8],'P1*x*P2',T',T);

    B = img(:,:,3);
    I = im2double(B);
    T = dctmtx(8);
    B = blkproc(I,[8 8],'P1*x*P2',T,T');
    mask = [1 1 1 1 0 0 0 0
            1 1 1 0 0 0 0 0
            1 1 0 0 0 0 0 0
            1 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0];
    B2 = blkproc(B,[8 8],'P1.*x',mask);
    I4 = blkproc(B2,[8 8],'P1*x*P2',T',T);
    L(:,:,:) = cat(3,I2, I3, I4);
end
