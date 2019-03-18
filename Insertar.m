clc
close all
clear all

term = '.png';
name ='imagepath';
ImOriginal = imread([name term]);
resize = 7;
ImOriginal = imresize(ImOriginal,resize,'Lanczos3');

tic

IYCbCr = double(rgb2ycbcr(ImOriginal)); 
Iorig = IYCbCr(:,:,1);
% tic
filtro = liftwave('db4');
[cA,cH,cV,cD] = lwt2(Iorig,filtro); % lifting wavelet transform
[cA2,cH2,cV2,cD2] = lwt2(cA,filtro);
[cA3,cH3,cV3,cD3] = lwt2(cH2,filtro);

Imp3 = cH3;
[y,x] = size(Imp3);
Step3 = 30;
autent = ones(y,x) * 255;
for j=1:1:y
    for i=1:1:x
        if autent(j,i) == 0
            Imp3(j,i) = sign(Imp3(j,i)) * floor(abs(Imp3(j,i))/(2 * Step3)) * 2 * Step3;
        else
            Imp3(j,i) = sign(Imp3(j,i)) * (floor(abs(Imp3(j,i))/(2 * Step3)) * 2 * Step3 + Step3);
        end
    end
end


cH2 = ilwt2(cA3,Imp3,cV3,cD3,filtro);
cA = ilwt2(cA2,cH2,cV2,cD2,filtro);
IorigW = ilwt2(cA,cH,cV,cD,filtro);

IYCbCr(:,:,1) = IorigW;
IorigW = ycbcr2rgb(uint8(IYCbCr));

toc

imwrite(uint8(ImOriginal),'Original.bmp')
imwrite(uint8(IorigW),'Marcado.jpg','Quality',100)

Mpsnr = psnr(ImOriginal,uint8(IorigW))


