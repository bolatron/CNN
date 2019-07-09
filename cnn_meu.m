function cnn
    t = cputime();
    %-- imagens para a rede --
    img{1}=imread('elem2.jpg');
    %img{2}=imread('dog2.jpg');
    %img{3}=imread('dog3.jpg');
    %img{4}=imread('dog4.jpeg');
    %img{5}=imread('cat1.jpg');
    %img{6}=imread('cat2.jpg');
    %img{7}=imread('cat3.jpg');
    %img{8}=imread('cat4.jpg');
    for i=1:1
        banco{i} = img{i};
    end
    t1 = [];
    t2 = [];
    y = [0:0];
    iter = 1000;
    l = 32;
    c = 32;
    p1 = 2;
    p2 = 4;
    qf = 23;
    lr = 0.01;
    tipo = 's';
    [output, t1, t2] = treinaCNN(banco, y, iter, t1, t2, qf, l, c, p1, p2, tipo, lr);
    %for i=1:1
        %i
        %saida = (testaCNN(img{i}, t1, t2, qf, l, c, p1, p2, tipo))*8
    %end
    printf('Total time: %f seconds\n', cputime-t);
end

function [output] = testaCNN(img, theta_1, theta_2, qf, l, c, p1, p2, tipo)
    x = [];
    [maxp, qf] = featuresmono(img, l, c, qf, p1, p2);
    for i=1:qf
        if tipo == 's'  
        mmaxp = max(maxp{i}(:));
            if mmaxp == 0;
                mmaxp = 1;
            end
        e{i} = maxp{i}(:)/mmaxp; 
        end
        if tipo == 'r' 
            e{i} = maxp{i}(:); 
        end
    end
    x = [x;cell2mat(e)(:)'];
    [output] = testaNN(x(:)', theta_1, theta_2, tipo);
end 

function [output, t1, t2] = treinaCNN(image, y, iter, theta_1, theta_2, qf, l, c, p1, p2, tipo, lr)
    x = [];
    qtd = length(image);
    for i=1:qtd
       [maxp, qf] = featuresmono(image{i}, l, c, qf, p1, p2);
%       for j=1:qf
%           if tipo == 's'
%               mmaxp = max(maxp{j}(:));
%               if mmaxp == 0
%                   mmaxp = 1;
%               end
%               e{j} = maxp{j}(:)/mmaxp;
%           end
%       end
%       x = [x;cell2mat(e)(:)'];
%    end
%    if tipo == 's'
%        if max(y) == 0
%            maxy = 1;
%        else
%            maxy = max(y);
%        end
%        y = y./maxy;
%    end
%    [output, t1, t2] = treinaNN(x, y', iter, tipo, lr);
%    if tipo == 's'
%        output = output*(max(y));
    end
end

function [maxp, qf] = featuresmono(image, l, c, qf, p1, p2)
    %img = rgb2gray(image);
    img = image;
    imwrite(img, 'teste1/normal.jpg');
    img = imresize(img, [l, c]);
    imwrite(img, 'teste1/resize.jpg');
    img = pool(img, p1, p1);
    imwrite(img, 'teste1/pool1.jpg');
    filt = convolucao(img);
    imwrite(filt{1}, 'teste1/mascara1.jpg');
    imwrite(filt{2}, 'teste1/mascara2.jpg');
    imwrite(filt{3}, 'teste1/mascara3.jpg');
    imwrite(filt{4}, 'teste1/mascara4.jpg');
    imwrite(filt{5}, 'teste1/mascara5.jpg');
    imwrite(filt{6}, 'teste1/mascara6.jpg');
    imwrite(filt{7}, 'teste1/mascara7.jpg');
    imwrite(filt{8}, 'teste1/mascara8.jpg');
    imwrite(filt{9}, 'teste1/mascara9.jpg');
    imwrite(filt{10}, 'teste1/mascara10.jpg');
    imwrite(filt{11}, 'teste1/mascara11.jpg');
    imwrite(filt{12}, 'teste1/mascara12.jpg');
    imwrite(filt{13}, 'teste1/mascara13.jpg');
    imwrite(filt{14}, 'teste1/mascara14.jpg');
    imwrite(filt{15}, 'teste1/mascara15.jpg');
    imwrite(filt{16}, 'teste1/mascara16.jpg');
    imwrite(filt{17}, 'teste1/mascara17.jpg');
    imwrite(filt{18}, 'teste1/mascara18.jpg');
    imwrite(filt{19}, 'teste1/mascara19.jpg');
    imwrite(filt{20}, 'teste1/mascara20.jpg');
    imwrite(filt{21}, 'teste1/mascara21.jpg');
    imwrite(filt{22}, 'teste1/mascara22.jpg');
    imwrite(filt{23}, 'teste1/mascara23.jpg');
    k = length(filt);
    if qf > k
        qf = k;
    end
    for j=1:qf
        maxp{j} = pool(filt{j}, p2, p2);
    end
    imwrite(maxp{1}, 'teste1/Zmascara1.jpg');
    imwrite(maxp{2}, 'teste1/Zmascara2.jpg');
    imwrite(maxp{3}, 'teste1/Zmascara3.jpg');
    imwrite(maxp{4}, 'teste1/Zmascara4.jpg');
    imwrite(maxp{5}, 'teste1/Zmascara5.jpg');
    imwrite(maxp{6}, 'teste1/Zmascara6.jpg');
    imwrite(maxp{7}, 'teste1/Zmascara7.jpg');
    imwrite(maxp{8}, 'teste1/Zmascara8.jpg');
    imwrite(maxp{9}, 'teste1/Zmascara9.jpg');
    imwrite(maxp{10}, 'teste1/Zmascara10.jpg');
    imwrite(maxp{11}, 'teste1/Zmascara11.jpg');
    imwrite(maxp{12}, 'teste1/Zmascara12.jpg');
    imwrite(maxp{13}, 'teste1/Zmascara13.jpg');
    imwrite(maxp{14}, 'teste1/Zmascara14.jpg');
    imwrite(maxp{15}, 'teste1/Zmascara15.jpg');
    imwrite(maxp{16}, 'teste1/Zmascara16.jpg');
    imwrite(maxp{17}, 'teste1/Zmascara17.jpg');
    imwrite(maxp{18}, 'teste1/Zmascara18.jpg');
    imwrite(maxp{19}, 'teste1/Zmascara19.jpg');
    imwrite(maxp{20}, 'teste1/Zmascara20.jpg');
    imwrite(maxp{21}, 'teste1/Zmascara21.jpg');
    imwrite(maxp{22}, 'teste1/Zmascara22.jpg');
    imwrite(maxp{23}, 'teste1/Zmascara23.jpg');
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

function [filt] = convolucao(img)
    img = double(img);
    mascara = [ 0 1 0;
                0 1 0;
                0 1 0]/3;
    filt{1}= conv2(img,mascara,'same');
    mascara = [ 0 0 0;
                0 1 1;
                1 1 0]/4;
    filt{2}= conv2(img,mascara,'same');
    mascara = [ 1 1 0;
                0 1 1;
                0 0 0]/3;
    filt{3}= conv2(img,mascara,'same');
    mascara = [ 0 0 0;
                1 1 1;
                0 0 0]/3;
    filt{4}= conv2(img,mascara,'same');
    mascara = [ 0 1 0;
                1 1 1;
                0 1 0]/4;
    filt{5}= conv2(img,mascara,'same');
    mascara = [ 1 0 1;
                0 1 0;
                1 0 1]/4;
    filt{6}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                0 1 0;
                0 1 0]/4;
    filt{7}= conv2(img,mascara,'same');
    mascara = [ 0 1 0;
                0 1 0;
                1 1 1]/4; 
    filt{8}= conv2(img,mascara,'same');
    mascara = [ 0 0 1;
                1 1 1;
                0 0 1]/4;
    filt{9}= conv2(img,mascara,'same');
    mascara = [ 1 0 0;
                1 1 1;
                1 0 0]/4;
    filt{10}= conv2(img,mascara,'same');
    mascara = [ 0 0 0;
                0 1 0;
                0 0 0];
    filt{11}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                1 0 1;
                1 1 1]/8;
    filt{12}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                1 1 1;
                1 1 1]/9;
    filt{13}= conv2(img,mascara,'same');
    mascara = [ 1 0 1;
                0 1 0;
                0 1 0]/4;
    filt{14}= conv2(img,mascara,'same');
    mascara = [ 0 1 0;
                0 1 0;
                1 0 1]/4;
    filt{15}= conv2(img,mascara,'same');
    mascara = [ 1 0 0;
                0 1 1;
                1 0 0]/4;
    filt{16}= conv2(img,mascara,'same');
    mascara = [ 0 0 1;
                1 1 0;
                0 0 1]/4;
    filt{17}= conv2(img,mascara,'same');
    mascara = [ 1 0 1;
                1 0 1;
                1 1 1]/7;
    filt{18}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                1 0 1;
                1 0 1]/7;
    filt{19}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                1 0 0;
                1 1 1]/7;
    filt{20}= conv2(img,mascara,'same');
    mascara = [ 1 1 1;
                0 0 1;
                1 1 1]/7;
    filt{21}= conv2(img,mascara,'same');
    mascara = [ 0 1 0;
                1 0 1;
                0 1 0]/4;
    filt{22}= conv2(img,mascara,'same');
    mascara = [ 0 -1 0;
               -1 5 -1;
                0 -1 0]/9;
    filt{23}= conv2(img,mascara,'same');
end

% Função que testa a validade dos pesos t1 e t2
function [output] = testaNN(x, theta_1, theta_2, tipo)
    a{1} = x';
    if tipo == 's'
        a{2} = 1./ (1+e.^-(theta_1*a{1}));
        a{3} = 1./ (1+e.^-(theta_2*a{2}));
    end
    output = a{3};
end

% Função que treina a rede neural
function [output, theta_1, theta_2] = treinaNN(x, y, iter, tipo, lr)
    % Transposta 
    a{1} = x';
    camada_1 = size(x');
    camada_2 = size(y');
    theta_1 = rand(camada_1(1), camada_1(1));
    theta_2 = rand(camada_2, camada_1(1));
    for i=1:iter
        if tipo == 's'
            a{2} = 1./(1+e.^-(theta_1*a{1}));
            a{3} = 1./(1+e.^-(theta_2*a{2}));
            erro_3 = (a{3} - y');
            %erro_2 = (theta_2' * erro_3).*a{2}.*(1-a{2});
            erro_2 = (theta_2' * erro_3).*(1./(1+e.^-a{2}));
            theta_1 = theta_1 - lr*(erro_2*a{1}');
            theta_2 = theta_2 - lr*(erro_3*a{2}');
        end
        sum(erro_3)/length(erro_3);
    end
    output = a{3};
end    