clc
close all
clear all

term = '.png';
name ='imagepath';
ImOriginal = imread([name term]);
resize = 7;
ImOriginal = imresize(ImOriginal,resize,'Lanczos3');

% poolobj = parpool;
% poolsize = poolobj.NumWorkers
tic
[rows,~,~]=size(ImOriginal);
threads = 4;
v = round(linspace(1,rows+1,threads+1));

for k=1:threads
    if k~=threads
        Im(k).I=(ImOriginal(v(k):v(k+1)-1,:,:));
    else
        Im(k).I =(ImOriginal(v(k):v(k+1)-1,:,:));
    end
    imwrite(uint8(Im(k).I),['imagen' num2str(k) '.tiff']);
end

% tic
filtro = liftwave('db4');
step = 30;
parfor k = 1:threads
%     tic
    Im(k).I = embedd(Im(k).I,filtro,step);
%     toc
    D{k} = Im(k).I;
end
% toc

IorigW = vertcat(D{1},D{2});
toc
% delete(gcp('nocreate'))
% imwrite(uint8(ImOriginal),'Original.bmp')
imwrite(uint8(IorigW),'MarcadoParalelo.jpg','Quality',100)

Mpsnr = psnr(ImOriginal,uint8(IorigW))
% [mssim, ssim_map] = ssim(ImOriginal,uint8(IorigW));
% mssim


