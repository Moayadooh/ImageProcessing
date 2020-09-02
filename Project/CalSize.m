function s = CalSize(file)
    InfoImage = imfinfo(file);
    N = InfoImage.Filename;
    fileinfo = dir(N);
    SIZE = fileinfo.bytes;
    s = SIZE/1024;
end
