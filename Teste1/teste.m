function teste
    pkg load image;
    %img{1} = imread('clavededo.png');
    %img{2} = imread('clavedefa.jpg');
    img{1} = imread('clavedesol.jpg');
    for i=1:1
        img{i} = (img{i}(:,:,1));
    end
    l = 64;
    c = 64;
    p1 = 2;
    y = 0;
    tipo = 's';
    iter = 1;
    lr = 1;
    weights_1 = rand(3380, 3380);
    weights_2 = rand(1, 3380);
    
    for i=1:1
        x = [];
        camada2 = featuresmono(img{i}, l, c, p1);
        for j=1:20
            camada2{j} = camada2{j}(:)/255;
        end
        %x = [x;cell2mat(camada2)(:)];
        %[o, w1, w2] = treinann(x, y', weights_1, weights_2, iter, tipo, lr);
        %weights_1 = w1;
        %weights_2 = w2;
    end
    %disp('Resposta:');
    %disp(o);
    
    %test{1} = imread('Clavededo/clave.jpg');
    %test{2} = imread('Clavededo/clave1.jpg');
    %test{3} = imread('Clavedesol/clave1.jpg');
    %for i=1:3
    %    test{i} = (test{i}(:,:,1));
    %end
    %for i=1:3
    %    x = [];
    %    camada2 = featuresmono(test{i}, l, c, p1);
    %    for j=1:20
    %        camada2{j} = camada2{j}(:)/255;
    %    end
    %    x = [x;cell2mat(camada2)(:)];
    %    [output] = testann(x, weights_1, weights_2, tipo);
    %    disp(output);
    %end
    
end

function [camada2] = featuresmono(image, l, c, p1)
    %img = rgb2gray(image);
    img = image;
    imwrite(img, 'normal.jpg');
    img = imresize(img, [l, c]);
    %img2 = imresize(img, [l-4, c-4]);
    imwrite(img, 'resize.jpg');
    filt = c1(img);
    imwrite(filt{1}, 'C1/mascara1.jpg');
    imwrite(filt{2}, 'C1/mascara2.jpg');
    imwrite(filt{3}, 'C1/mascara3.jpg');
    imwrite(filt{4}, 'C1/mascara4.jpg');
    imwrite(filt{5}, 'C1/mascara5.jpg');
    imwrite(filt{6}, 'C1/mascara6.jpg');
    imwrite(filt{7}, 'C1/mascara7.jpg');
    imwrite(filt{8}, 'C1/mascara8.jpg');
    imwrite(filt{9}, 'C1/mascara9.jpg');
    imwrite(filt{10}, 'C1/mascara10.jpg');
    imshow([filt{6}, filt{5}]);
    for i=1:10
        filt{i} = pool(filt{i}, p1, p1);
    end
    imwrite(filt{1}, 'P1/mascara1.jpg');
    imwrite(filt{2}, 'P1/mascara2.jpg');
    imwrite(filt{3}, 'P1/mascara3.jpg');
    imwrite(filt{4}, 'P1/mascara4.jpg');
    imwrite(filt{5}, 'P1/mascara5.jpg');
    imwrite(filt{6}, 'P1/mascara6.jpg');
    imwrite(filt{7}, 'P1/mascara7.jpg');
    imwrite(filt{8}, 'P1/mascara8.jpg');
    imwrite(filt{9}, 'P1/mascara9.jpg');
    imwrite(filt{10}, 'P1/mascara10.jpg');
    j=1;
    for i=1:10
        img = double(filt{i});
        mascara = [  0  0  0  0  0;
                     0 -1 -1 -1  0;
                     0 -1  8 -1  0;
                     0 -1 -1 -1  0;
                     0  0  0  0  0]/10;
        camada2{j} = conv2(img, mascara, 'valid');
        j = j + 1;
        mascara = [  0 -1  0  1  0;
                     0 -2  0  2  0;
                     0 -3  0  3  0;
                     0 -2  0  2  0;
                     0 -1  0  1  0]/10;
        camada2{j} = conv2(img, mascara, 'valid');
        j = j + 1;
    end
    imwrite(camada2{1}, 'C2/mascara1.jpg');
    imwrite(camada2{2}, 'C2/mascara2.jpg');
    imwrite(camada2{3}, 'C2/mascara3.jpg');
    imwrite(camada2{4}, 'C2/mascara4.jpg');
    imwrite(camada2{5}, 'C2/mascara5.jpg');
    imwrite(camada2{6}, 'C2/mascara6.jpg');
    imwrite(camada2{7}, 'C2/mascara7.jpg');
    imwrite(camada2{8}, 'C2/mascara8.jpg');
    imwrite(camada2{9}, 'C2/mascara9.jpg');
    imwrite(camada2{10}, 'C2/mascara10.jpg');
    imwrite(camada2{11}, 'C2/mascara11.jpg');
    imwrite(camada2{12}, 'C2/mascara12.jpg');
    imwrite(camada2{13}, 'C2/mascara13.jpg');
    imwrite(camada2{14}, 'C2/mascara14.jpg');
    imwrite(camada2{15}, 'C2/mascara15.jpg');
    imwrite(camada2{16}, 'C2/mascara16.jpg');
    imwrite(camada2{17}, 'C2/mascara17.jpg');
    imwrite(camada2{18}, 'C2/mascara18.jpg');
    imwrite(camada2{19}, 'C2/mascara19.jpg');
    imwrite(camada2{20}, 'C2/mascara20.jpg');
    for i=1:20
        camada2{i} = pool(camada2{i}, p1, p1);
    end
    imwrite(camada2{2}, 'P2/mascara2.jpg');
    imwrite(camada2{3}, 'P2/mascara3.jpg');
    imwrite(camada2{4}, 'P2/mascara4.jpg');
    imwrite(camada2{5}, 'P2/mascara5.jpg');
    imwrite(camada2{6}, 'P2/mascara6.jpg');
    imwrite(camada2{7}, 'P2/mascara7.jpg');
    imwrite(camada2{8}, 'P2/mascara8.jpg');
    imwrite(camada2{9}, 'P2/mascara9.jpg');
    imwrite(camada2{10}, 'P2/mascara10.jpg');
    imwrite(camada2{11}, 'P2/mascara11.jpg');
    imwrite(camada2{12}, 'P2/mascara12.jpg');
    imwrite(camada2{13}, 'P2/mascara13.jpg');
    imwrite(camada2{14}, 'P2/mascara14.jpg');
    imwrite(camada2{15}, 'P2/mascara15.jpg');
    imwrite(camada2{16}, 'P2/mascara16.jpg');
    imwrite(camada2{17}, 'P2/mascara17.jpg');
    imwrite(camada2{18}, 'P2/mascara18.jpg');
    imwrite(camada2{19}, 'P2/mascara19.jpg');
    imwrite(camada2{20}, 'P2/mascara20.jpg');
end


function [filt] = c1(img)
    img = double(img);
    mascara = [  1  1  1  1  0;
                 1  1  1  0  0;
                 1  1  0  0  0;
                 1  0  0  0  0;
                 0  0  0  0  0]/10;
    filt{1} = conv2(img,mascara, 'valid');
    mascara = [  0  1  1  1  1;
                 0  0  1  1  1;
                 0  0  0  1  1;
                 0  0  0  0  1;
                 0  0  0  0  0]/10;
    filt{2} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  0;
                 1  0  0  0  0;
                 1  1  0  0  0;
                 1  1  1  0  0;
                 1  1  1  1  0]/10;
    filt{3} = conv2(img, mascara, 'valid');
    mascara = [  0  0  1  0  0;
                 0  0  1  0  0;
                 0  0  1  0  0;
                 0  0  1  0  0;
                 0  0  1  0  0]/5;
    filt{4} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  0;
                 0  0  0  0  0;
                 1  1  1  1  1;
                 0  0  0  0  0;
                 0  0  0  0  0]/5;
    filt{5} = conv2(img, mascara, 'valid');
    mascara = [  1  0  0  0  0;
                 0  1  0  0  0;
                 0  0  1  0  0;
                 0  0  0  1  0;
                 0  0  0  0  1]/5;
    filt{6} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  1;
                 0  0  0  1  0;
                 0  0  1  0  0;
                 0  1  0  0  0;
                 1  0  0  0  0]/5;
    filt{7} = conv2(img, mascara, 'valid');
    mascara = [  0  1  1  1  0;
                 1  1  1  1  1;
                 1  1  1  1  1;
                 1  1  1  1  1;
                 0  1  1  1  0]/21;
    filt{8} = conv2(img, mascara, 'valid');
    mascara = [  1  1  1  1  1;
                 1  1  1  1  1;
                 1  1  1  1  1;
                 1  1  1  1  1;
                 1  1  1  1  1]/25;
    filt{9} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  0;
                 0  0  0  0  1;
                 0  0  0  1  1;
                 0  0  1  1  1;
                 0  1  1  1  1]/10;
    filt{10} = conv2(img, mascara, 'valid');
end

function [filt] = c2(img)
    img = double(img);
    mascara = [  0  0  0  0  0;
                 0 -1 -1 -1  0;
                 0 -1  8 -1  0;
                 0 -1 -1 -1  0;
                 0  0  0  0  0]/10;
    filt{1} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  0;
                -1 -1 -1 -1 -1;
                 0  0  0  0  0;
                 1  1  1  1  1;
                 0  0  0  0  0]/10;
    filt{2} = conv2(img, mascara, 'valid');
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
            maximg(i, j) = min([255, img(i, j)]);
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
            pool(pi,pj) = min(min(img(i:liml, j:limc)));
        end
    end
end

function [output] = testann(x, w1, w2, tipo)
    %transposta para camada de entrada
    a{1} = x;
    if tipo == 's'
        a{2} = 1./ (1+e.^-(w1*a{1}));
        a{3} = 1./ (1+e.^-(w2*a{2}));
    end
    if tipo == 'r'
        m1 = w1*a{1};
        a{2} = max(m1,0.1); 
        m2 = w*a{2};
        a{3} = m2;
    end   
    output = a{3}; 
end

function [output,w1,w2] = treinann(x, y, w1, w2, iter, tipo, lr)
    %laco para o numero de iterações para aprendizado
    a{1} = x;
    for i=1:iter 
        if tipo == 's'
            %calculo das saida de cada camada
            a{2} = 1./ (1+e.^-(w1*a{1}));
            a{3} = 1./ (1+e.^-(w2*a{2})); 
            %back propagation para calcular o error
            erro_3 = (y - a{3});
            %erro_2 = (w2' * erro_3).* a{2}.*(1-a{2});
            erro_2 = (w2' * erro_3).* (1./(1+e.^-a{2}));
            %subtração de derivadas parciais do theta para atualização dos pesos
            w1 = w1 + lr*(erro_2 * a{1}');
            w2 = w2 + lr*(erro_3 * a{2}');  
        end 
        if tipo == 'r'
            disp('foi');
            %a{2}=theta_1*a{1};
            a{2} = max(w1*a{1}, 0.1);  # using ReLU as activate function
            a{3}=  max(w2*a{2}, 0.1);

            # Backprop to compute gradients of w1 and w2 with respect to loss
            erro_3 = 2*(a{3} - y); # the last layer's error
            erro_2=double(w2'*a{3}>=0);  # the derivate of ReLU
            

            # Update weights
            w1 = w1 - lr * (erro_2*a{1}');
            w2 = w2 - lr * (erro_3*a{2}');
        end 
    end
    output = a{3};
end 