clc
close all
clear all

term = '.jpg';
name ='MarcadoParalelo';
ImOriginal = imread([name term]);
resize = 8;
tic
[rows,~,~]=size(ImOriginal);
threads = 2;
v = round(linspace(1,rows+1,threads+1));

for k=1:threads
    if k~=threads
        Im(k).I=(ImOriginal(v(k):v(k+1)-1,:,:));
    else
        Im(k).I =(ImOriginal(v(k):v(k+1)-1,:,:));
    end
end

% tic
filtro = liftwave('db4');
step = 30;
parfor k = 1:threads
%     tic
    Im(k).I = extract(Im(k).I,filtro,step,resize);
%     toc
    D{k} = Im(k).I;
end
% toc

IorigW = vertcat(D{1},D{2});
toc

imwrite(uint8(IorigW),'Autenticacion.tif')