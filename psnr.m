function ratio=psnr(orig, dith)
    orig = double(orig);
    dith = double(dith);
    [x y z]=size(orig);
    MSE=sum(sum(sum((orig-dith).^2)));
    MSE=(1/(x*y*z))*MSE;
    ratio = 10*log10((255^2)/MSE);
end
