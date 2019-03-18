function salida = embedd(entrada,filtro,Step3)
    IYCbCr = double(rgb2ycbcr(entrada)); 
    Iorig = IYCbCr(:,:,1);
    [cA,cH,cV,cD] = lwt2(Iorig,filtro);
    [cA2,cH2,cV2,cD2] = lwt2(cA,filtro);
    [cA3,cH3,cV3,cD3] = lwt2(cH2,filtro);

    Imp3 = cH3;
    [y,x] = size(Imp3);
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

    %% Transformadas inversas de Wavelet
    cH2 = ilwt2(cA3,Imp3,cV3,cD3,filtro);
    cA = ilwt2(cA2,cH2,cV2,cD2,filtro);
    IorigW = ilwt2(cA,cH,cV,cD,filtro);
    IYCbCr(:,:,1) = IorigW;
    salida = ycbcr2rgb(uint8(IYCbCr));