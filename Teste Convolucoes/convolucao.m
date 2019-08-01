function convolucao
    pkg load image;
    img = imread('clave.jpg');
    l = 62;
    c = 62;
    p1 = 2;
    featuresmono(img, l, c, p1);
end

function featuresmono(image, l, c, p1)
    %img = rgb2gray(image);
    img = image;
    imwrite(img, 'normal.jpg');
    img = imresize(img, [l, c]);
    imwrite(img, 'resize.jpg');
    %img = pool(img, p1, p1);
    %imwrite(img, 'pool1.jpg');
    filt = convolucao(img);
    imwrite(filt{1}, 'mascara1.jpg');
    imwrite(filt{2}, 'mascara2.jpg');
    imwrite(filt{3}, 'mascara3.jpg');
    imwrite(filt{4}, 'mascara4.jpg');
end


function [filt] = convolucao(img)
    img = double(img);
    mascara = [ -1 -1 -1;
                 0  0  0;
                 1  1  1];
    filt{1} = conv2(img,mascara,'same');
    mascara = [  1  1  1;
                 0  0  0;
                -1 -1 -1];
    filt{2} = conv2(img, mascara, 'same');
    mascara = [  1  1  1;
                 1  1  1;
                 1  1  1]/9;
    filt{3} = conv2(img, mascara, 'same');
    mascara = [  0  1  0;
                 0  1  0;
                 0  1  0]/3;
    filt{4} = conv2(img, mascara, 'same');
end

function maxp = pool(filt, l, c)
    maxs = maxsoft(filt);
    %imshow(maxs,[]),drawnow;
    maxp = maxpool(maxs, l, c);
    %imshow(maxp,[]),drawnow; 
end

function [maximg] = maxsoft(img)
    [l, c] = size(img);
    for i=1:l
        for j=1:c
            maximg(i, j) = max([0, img(i, j)]);
        end
    end
end

function [pool] = maxpool(img, lm, cm)
    [li, ci] = size(img);
    pi = 0;
    pj = 0;
    for i=1:lm:li
        pi = pi + 1;
        pj = 0;
        for j=1:cm:ci
            pj = pj + 1;
            liml = i + lm - 1;
            limc = j + cm - 1;
            if liml > li
                liml = li;
            end
            if limc > ci
                limc = ci;
            end
            pool(pi,pj) = max(max(img(i:liml, j:limc)));
        end
    end
end