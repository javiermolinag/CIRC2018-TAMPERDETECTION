function salida = extract(entrada,filtro,Step,resize)
    IYCbCr = double(rgb2ycbcr(entrada)); 
    Iorig = IYCbCr(:,:,1);
    [cA,cH,cV,cD] = lwt2(Iorig,filtro);
    [cA2,cH2,cV2,cD2] = lwt2(cH,filtro);
    [cA3,cH3,cV3,cD3] = lwt2(cH2,filtro);

    Imp3 = cV3;
    [y,x] = size(Imp3);
    for j=1:1:y
        for i=1:1:x
            val = round(Imp3(j,i) / Step);
            if mod(val,2) == 0
                Waut(j,i) = 0;
            else
                Waut(j,i) = 255;
            end
        end
    end
    salida = imresize(Waut,resize,'nearest');
  
