clc
close all
clear all

%% Se lee imagen
term = '.jpg';
name ='Marcado';
ImWtmkd = double(imread([name term]));

tic
resize = 8;
ImWtmkd = double(rgb2ycbcr(ImWtmkd));
ImWtmkd = ImWtmkd(:,:,1);

filtro = liftwave('db4');
[cA,cH,cV,cD] = lwt2(ImWtmkd,filtro); 
[cA2,cH2,cV2,cD2] = lwt2(cA,filtro);
[cA3,cH3,cV3,cD3] = lwt2(cH2,filtro);
% [cA4,cH4,cV4,cD4] = lwt2(cH3,filtro);


%% Autenticacion
Imp3 = cH3;
[y,x] = size(Imp3);
Step2 = 30;
Waut = ones(y,x) * 127;
for j=1:1:y
    for i=1:1:x
        val = round(Imp3(j,i) / Step2);
        if mod(val,2) == 0
            Waut(j,i) = 0;
        else
            Waut(j,i) = 255;
        end
    end
end

Waut2 = imresize(Waut,resize,'nearest');
toc

imwrite(uint8(Waut2),'Au.tif')