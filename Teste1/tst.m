function tst
    mascara = [ 80 80 80 80 80 80 80 80 80 80;
                80 80 80 80 80 80 80 80 80 80;
                80 80 50 50 50 50 50 50 80 80;
                80 80 50 30 30 30 30 50 80 80;
                80 80 50 30 10 10 30 50 80 80;
                80 80 50 30 10 10 30 50 80 80;
                80 80 50 30 30 30 30 50 80 80;
                80 80 50 50 50 50 50 50 80 80;
                80 80 80 80 80 80 80 80 80 80;
                80 80 80 80 80 80 80 80 80 80]/-100;
    imshow(mascara);
    disp([0:17]);
    I = imread('Clavededo/clave1.jpg');
    disp(size(I));
end

function img = maxpool(img, stride_1, stride_2)
    img = double(img);
    fun = @(img) Max(img(:));
    img = blockprop(img, [stride_1, stride_2], fun);
end

function img = convs(img, mask, stride_1, stride_2)
    img = double(img);
    filt = @(img) conv2(img, mask, 'valid');
    img = blockprop(img, [stride_1, stride_2], filt);
