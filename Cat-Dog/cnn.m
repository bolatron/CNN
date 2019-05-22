function cnn

  
  img{1}=imread('dog1.jpg');
  img{2}=imread('dog2.jpg');
  img{3}=imread('dog3.jpg');
  img{4}=imread('dog4.jpeg');
  img{5}=imread('cat1.jpg');
  img{6}=imread('cat2.jpg');
  img{7}=imread('cat3.jpg');
  img{8}=imread('cat4.jpg');
  img{9}=imread('dog5.jpg');
  img{10}=imread('cat5.jpg');
  img{11}=imread('cat6.png');
  img{12}=imread('dog6.jpg');
  img{13}=imread('dog7.jpg');
  img{14}=imread('dog8.jpg');
  
t1=[];
t2=[];
for i=1:8
 banco{i}=img{i};
end
%for i=19:36 
%  banco{i}=imrotate(img{i-18},90);;
%end



%banco{5}=img{5};
%banco{6}=img{10};
%banco{7}=img{11};
%banco{8}=img{12};
%banco{9}=img{13};
%banco{10}=img{14};
%  
%banco{1}=img{1};

l=32;
c=32;
p1=2;
p2=4;
qf=20;
  
 [output,t1,t2]=treinacnn(banco,[0:7],20000,t1,t2,qf,l,c,p1,p2,'s',0.01);
 
for i=1:14
  i
  saida=(testacnn(img{i},t1,t2,qf,l,c,p1,p2,'s'))*10
end
%saida = (testacnn(img{9}, t1, t2, qf, l, c, p1, p2, 's')*10

%  [output]=testacnn(img{2},t1,t2)
%  
 




 
   
   %relu
%   rl=max
  

%  teste=edge(d1,"Sobel");
%  teste2=maxsoft(teste);
%  teste3=maxpool(teste2,4,4);
%  subplot(2,3,1),%imshow(d1);
%  subplot(2,3,2),%imshow(teste2);
%  subplot(2,3,3),%imshow(teste3);
%  teste4=edge(teste3,"Sobel");
%  teste5=maxsoft(teste4);
%  teste6=maxpool(teste5,4,4);
%  subplot(2,3,4),%imshow(teste4);
%  subplot(2,3,5),%imshow(teste5);
%  subplot(2,3,6),%imshow(teste6);
end

 
function [output]=testacnn(img,theta_1,theta_2,qf,l,c,p1,p2,tipo)
 [maxp,qf]=featuresmono(img,l,c,qf,p1,p2);
 for i=1:qf
  if tipo=='s'  
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
 [output] = testann(x(:)',theta_1,theta_2,tipo);
end  


function [output,theta_1,theta_2]=treinacnn(image,y,iter,theta_1,theta_2,qf,l,c,p1,p2,tipo,lr)
 x=[];
 banco=length(image);
 for i=1:banco
    [maxp,qf]=featuresmono(image{i},l,c,qf,p1,p2) ;
  for i=1:qf
    if tipo=='s'  
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
  if tipo='s'
    if max(y)==0
      maxy=1;
    else
      maxy=max(y);
    end  
    y=y./maxy; 
  end
  [output,theta_1,theta_2] = treinann(x,y',iter,tipo,lr);
  if tipo='s'
    output=output*(max(y)); 
  end
end

function [maxp,qf]=featuresmono(image,l,c,qf,p1,p2) 
  %imshow(image),drawnow;
  img=rgb2gray(image);
  %imshow(img),drawnow;
  img=imresize(img,[l,c]); 
  %imshow(img),drawnow;
%  img=edge(img,'sobel'); 
  %imshow(img,[]),drawnow;
  img=pool(img,p1,p1);
  %imshow(img,[]),drawnow;
  filt=convolucao(img);
  k=length(filt);
  if qf>k
    qf=k;
  end
  for j=1:qf
    %imshow(filt{j},[]),drawnow;
    maxp{j}=pool(filt{j},p2,p2);
    %imshow(maxp{j},[]),drawnow;
   end
 end


function [filt]=convolucao(img)
  img=double(img);
   mascara=[  0 1 0;
              0 1 0;
              0 1 0 ]/3;
   filt{1}= conv2(img,mascara,'same');
   mascara=[ 0 0 1;
             0 1 0;
             1 0 0]/3;
   filt{2}= conv2(img,mascara,'same');
   mascara=[ 1 0 0;
             0 1 0;
             0 0 1]/3;
   filt{3}= conv2(img,mascara,'same');
   mascara=[ 0 0 0;
             1 1 1;
             0 0 0]/3;
   filt{4}= conv2(img,mascara,'same');
   mascara=[ 0 1 0;
             1 1 1;
             0 1 0]/4;
    filt{5}= conv2(img,mascara,'same');
     mascara=[1 0 1;
              0 1 0;
              1 0 1]/4;
    filt{6}= conv2(img,mascara,'same');
    mascara=[ 1 1 1;
              0 1 0;
              0 1 0]/4;
    filt{7}= conv2(img,mascara,'same');
    mascara=[ 0 1 0;
              0 1 0;
              1 1 1]/4;
              
    filt{8}= conv2(img,mascara,'same');
    mascara=[  0 0 1;
               1 1 1;
               0 0 1]/4;
    filt{9}= conv2(img,mascara,'same');
    mascara=[ 1 0 0 ;
              1 1 1 ;
              1 0 0 ]/4;
    filt{10}= conv2(img,mascara,'same');
    mascara=[ 0 0 0;
              0 1 0;
              0 0 0];
    filt{11}= conv2(img,mascara,'same');
    mascara=[ 1 1 1;
              1 0 1;
              1 1 1]/8;
    filt{12}= conv2(img,mascara,'same');
    mascara=[ 1 1 1 ;
              1 1 1 ;
              1 1 1 ]/9;
    filt{13}= conv2(img,mascara,'same');
    mascara=[ 1 0 1 ;
              0 1 0 ;
              0 1 0 ]/4;
    filt{14}= conv2(img,mascara,'same');
    mascara=[ 0 1 0;
              0 1 0;
              1 0 1]/4;
    filt{15}= conv2(img,mascara,'same');
    mascara=[ 
              1 0 0;
              0 1 1;
              1 0 0]/4;
    filt{16}= conv2(img,mascara,'same');
    mascara=[ 0 0 1;
              1 1 0;
              0 0 1]/4;
    filt{17}= conv2(img,mascara,'same');
     mascara=[1 0 1;
              1 0 1;
              1 1 1]/7;
    filt{18}= conv2(img,mascara,'same');
     mascara=[1 1 1;
              1 0 1;
              1 0 1]/7;
    filt{19}= conv2(img,mascara,'same');
     mascara=[1 1 1;
              1 0 0;
              1 1 1]/7;
    filt{20}= conv2(img,mascara,'same');
    mascara=[1 1 1;
             0 0 1;
             1 1 1]/7;
    filt{21}= conv2(img,mascara,'same');
     mascara=  [0 1 0;
                1 0 1;
                0 1 0]/4;
    filt{22}= conv2(img,mascara,'same');
end
 
function maxp=pool(filt,l,c)
  
   maxs=maxsoft(filt);
%% %imshow(maxs,[]),drawnow;
 maxp=maxpool(maxs,l,c);
% %imshow(maxp,[]),drawnow; 
end

function [output] = testann(x,theta_1,theta_2,tipo)

  %transposta para camada de entrada
  a{1} = x';
 
if tipo=='s'
   a{2}= 1./ (1+e.^-(theta_1*a{1}));
   a{3}= 1./ (1+e.^-(theta_2*a{2}));
end
if tipo=='r'
  m1=theta_1*a{1};
   a{2}=max(m1,0.1); 
   m2=theta_2*a{2};
   a{3}=m2;
end   
output=a{3}; 

end

function [output,theta_1,theta_2] = treinann(x,y,iter,tipo='s',lr=1)

  %transposta para camada de entrada
  a{1} = x';
  camada_1=size(x');
  camada_2=size(y');

  %valores aleatorios iniciais
   theta_1 = rand(camada_1(1),camada_1(1));
  theta_2 = rand(camada_2,camada_1(1));


  
  %laco para o numero de iterações para aprendizado
  for i=1:iter 
    if tipo=='s'
    %calculo das saida de cada camada
     a{2}= 1./ (1+e.^-(theta_1*a{1}));
     a{3}= 1./ (1+e.^-(theta_2*a{2}));
    %back propagation para calcular o error
     erro_3= (a{3}-y');
%    erro_2 = (theta_2' * erro_3).* a{2}.*(1-a{2});
     erro_2 = (theta_2' * erro_3).* (1./(1+e.^-a{2}));
   %subtração de derivadas parciais do theta para atualização dos pesos
    theta_1=theta_1 - lr*(erro_2 * a{1}');
    theta_2=theta_2 - lr*(erro_3 * a{2}');  
  end 
   
    if tipo=='r'
      
%     a{2}=theta_1*a{1};
    a{2} = max(theta_1*a{1}, 0.1);  # using ReLU as activate function
    a{3}=  max(theta_2*a{2}, 0.1);

    # Backprop to compute gradients of w1 and w2 with respect to loss
    erro_3 = 2*(a{3} - y'); # the last layer's error
    erro_2=double(theta_2'*a{3}>=0);  # the derivate of ReLU
    

    # Update weights
    theta_1 =theta_1 - lr * erro_2*a{1}';
    theta_2 = theta_2 - lr * erro_3*a{2}';
 
    end 

   sum(erro_3)/length(erro_3);
    
  end
  output = a{3};

  end 



function [maximg]=maxsoft(image)
  [l,c]=size(image);
  for i=1:l
    for j=1:c
      maximg(i,j)=max([0,image(i,j)]);
    end
  end
end
function [pool]=maxpool(image,lm,cm)
  [li,ci]=size(image);
  
%    for i=1:lm:li
%     for j=1:cm:ci
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
%        j
%    subplot(1,2,1),%imshow(image(i:liml,j:limc));
%    subplot(1,2,2),%imshow(pool),drawnow
       %     %imshow(image(i:i+lm-1,j:j+cm-1));
      end
    end
  end 