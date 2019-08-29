function leNet5
    pkg load image;
    t = cputime;
    % loading images for training
    
 %   train = load_train_db();
    
    % loading images for testing
    
  %  test = load_train_db();
    
    % parameters
    w1 = [];
    w2 = [];
    c = 32;
    l = 32;
    pool_size = 2;
    pool_stride = 2;
    type = 'sigmoid';
    epochs = 42;
    learning_rate = 0.01;
    y = [];
    disp('aqui');
    for i=1:2314
        if i <= 552
            y = [y; 1 0 0 0 0 0 0];    
        end
        if i > 552 && i <= 935
            y = [y; 0 1 0 0 0 0 0];
        end
        if i > 935 && i <= 1309
            y = [y; 0 0 1 0 0 0 0];
        end
        if i > 1309 && i <= 1589
            y = [y; 0 0 0 1 0 0 0];
        end
        if i > 1589 && i <= 1776
            y = [y; 0 0 0 0 1 0 0];
        end
        if i > 1776 && i <= 2042
            y = [y; 0 0 0 0 0 1 0];
        end
        if i > 2042 && i <= 2314
            y = [y; 0 0 0 0 0 0 1];
        end
    end
    disp(size(y));
    %filt = c1(train{202}, activation = 'relu');
    %filt2 = c2(train{202}, activation = 'relu');
    %[maxp, qf] = featuresmono(train{120}, l, c, pool_size, pool_stride);
    %imshow([maxp{1}]);
    %imshow([filt2{1}, filt2{2}, filt2{3}, filt2{4}, filt2{5}, filt2{6}, filt2{7}, filt2{8}, filt2{9}, filt2{10}]);
    %imshow([filt{1},filt{2},filt{3},filt{4}]);
    %[maxp, qf] = featuresmono(train{1}, l, c, pool_size, pool_stride);
    %[w1, w2] = treinacnn(train, y, epochs, w1, w2, l, c, pool_size, pool_stride, type, learning_rate);
    
    for i=1:length(test)
        i
        saida = (testacnn(test{i}, w1, w2, l, c, pool_size, pool_stride, type))
    end
    printf('Total cpu time: %f seconds\n', cputime-t);
end

function [output]=testacnn(img, weight_1, weight_2, l, c, p1, p2, tipo)
    qf=0;
    [maxp,qf]=featuresmono(img, l, c, p1, p2);
    for i=1:qf
  if tipo=='sigmoid'  
  mmaxp=max(maxp{i}(:));
  if mmaxp==0;
   mmaxp=1;
  end
  e{i}=maxp{i}(:)/mmaxp; 
 end
 if tipo=='r' 
  e{i}=maxp{i}(:); 
 end
end
 x=cell2mat(e);
 [output] = testann(x(:)',weight_1,weight_2,tipo);
end  


function [weight_1, weight_2] = treinacnn(image, y, epochs, weight_1, weight_2, l, c, pool_size, pool_stride, tipo, lr)
    x=[];
    length_image = length(image);
    for i=1:length_image
        [maxp, qf] = featuresmono(image{i}, l, c, pool_size, pool_stride);
        for i=1:qf
            if tipo=='sigmoid'  
                mmaxp=max(maxp{i}(:));
                if mmaxp==0;
                    mmaxp=1;
                end
                e{i}=maxp{i}(:)/mmaxp; 
            end
            if tipo=='r' 
                e{i}=maxp{i}(:); 
            end
        end
        x=[x;cell2mat(e)(:)'];
    end  
    if tipo=='sigmoid'
        if max(y)==0
            maxy=1;
        else
            maxy=max(y);
        end  
        y=y./maxy; 
    end
    [output,weight_1,weight_2] = treinann(x,y,epochs,tipo,lr);
    if tipo=='sigmoid'
        output=output;
    end
end

function [maxp, qf] = featuresmono(image, l, c, pool_size, pool_stride)
    k = 1;
    img = double(image); 
    img = imresize(img, [l, c]); 
    filters_1 = c1(img, activation = 'relu');
    for i=1:4
        filt{i} = maxpool(filters_1{i}, pool_size, pool_stride);
        filters_2 = c2(filt{i}, activation = 'relu');
        for j=1:10
            filt2{j} = maxpool(filters_2{j}, pool_size, pool_stride);
            maxp{k} = filt2{j};
            k = k + 1;
        end
    end
    qf = 40;
end

function [filt] = c1(img, activation)
    mascara = [  0  0  0  0  0;
                 0 -1 -1 -1  0;
                 0 -1  8 -1  0;
                 0 -1 -1 -1  0;
                 0  0  0  0  0]/8;
    filt{1} = conv2(img, mascara, 'valid');
    mascara = [  0  0  0  0  0;
                -1 -2 -3 -2 -1;
                 0  0  0  0  0;
                 1  2  3  2  1;
                 0  0  0  0  0]/9;
    filt{2} = conv2(img, mascara, 'valid');
    mascara = [  0 -1  0  1  0;
                 0 -2  0  2  0;
                 0 -3  0  3  0;
                 0 -2  0  2  0;
                 0 -1  0  1  0]/9;
    filt{3} = conv2(img, mascara, 'valid');
    mascara = [  0 -5  0  1  0;
                 0 -4  0  2  0;
                 0 -3  0  3  0;
                 0 -2  0  4  0;
                 0 -1  0  5  0]/15;
    filt{4} = conv2(img, mascara, 'valid');
    if activation == 'relu'
        for i=1:4
            filt{i} = maxsoft(filt{i});
        end
    end
end

function [filt] = c2(img, activation)
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
    if activation == 'relu'
        for i=1:10
            filt{i} = maxsoft(filt{i});
        end
    end
end
 
function maxp=pool(filt,l,c)
    maxs = maxsoft(filt);
    maxp = maxpool(maxs,l,c); 
end

function [output] = testann(x,weight_1,weight_2,tipo)

  %transposta para camada de entrada
  a{1} = x';
 
if tipo=='sigmoid'
   a{2}= 1./ (1+e.^-(weight_1*a{1}));
   a{3}= 1./ (1+e.^-(weight_2*a{2}));
end
if tipo=='r'
  m1=weight_1*a{1};
   a{2}=max(m1,0.1); 
   m2=weight_2*a{2};
   a{3}=m2;
end   
output=a{3}; 

end

function [output,weight_1,weight_2] = treinann(x, y, epochs, tipo, lr)

  %transposta para camada de entrada
  a{1} = x';
  %valores aleatorios iniciais
   weight_1 = rand(1000, 1000);
  weight_2 = rand(7, 1000);


  
  %laco para o numero de epochsações para aprendizado
  for i=1:epochs 
    if tipo=='sigmoid'
    %calculo das saida de cada camada
     a{2}= 1./ (1+e.^-(weight_1*a{1}));
     a{3}= 1./ (1+e.^-(weight_2*a{2}));
    %back propagation para calcular o error
     erro_3= (a{3}-y');
%    erro_2 = (weight_2' * erro_3).* a{2}.*(1-a{2});
     erro_2 = (weight_2' * erro_3).* (1./(1+e.^-a{2}));
   %subtração de derivadas parciais do weight para atualização dos pesos
    weight_1=weight_1 - lr*(erro_2 * a{1}');
    weight_2=weight_2 - lr*(erro_3 * a{2}');  
  end 
  end
  output = a{3};

  end 


% Formaliza a imagem para que n�o tenha 
function [maximg]=maxsoft(image)
  [l,c]=size(image);
  for i=1:l
    for j=1:c
      maximg(i,j)=max([0,image(i,j)]);
    end
  end
end

% Faz o pooling e resulta o maior valor
function [pool]=maxpool(image,lm,cm)
    [li,ci]=size(image);
     pi=0;
     pj=0;
     for i=1:lm:li
        pi=pi+1;
        pj=0;
        for j=1:cm:ci
            pj=pj+1;
            liml = i+lm-1; 
            limc = j+cm-1; 
            if liml>li
                liml=li;
            end
            if limc>ci
                limc=ci;
            end  
            pool(pi,pj)=max(max(image(i:liml,j:limc)));
        end
    end
end