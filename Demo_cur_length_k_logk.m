clc;clear
% Im = im2double(imread('Large—one.png'));
addpath('E:\Paper\Quaternion\Data');
Im = im2double(imread('kodim02.png'));
[n1,n2,n3] = size(Im); m = n1; n = n2;
maxP = max(Im(:));
QIm=quaternion(Im(:,:,1),Im(:,:,2),Im(:,:,3)); % Original
sizeData = size(QIm);
Ob_QIm= vector(zerosq(n1,n2));
SR=0.2;  %sampling ratio 
% load Omega_SR_20.mat
Omega = find(rand(n1,n2)<=SR);
% load Baboon_SR_0.2.mat
%load Big_kodim02_SR_0.1.mat
data=QIm(Omega);
Ob_QIm(Omega)=data; % Observed
X= Ob_QIm;
for i = 1:1
   for k = [ 23 28] 
      % for con2 = [60 80 100 120 140 160 180 200]
        opts.XTrue = Im;
        opts.con = ceil(k * log(k)); opts.con2 = ceil(k * log(k));
        opts.resample  = true;
        opts.tol = 1e-4;
        opts.maxIter = 200;
        tStart = tic;
        [X,TX,errList,~] = cur_length(X, Omega,opts);
         time= toc(tStart);
                   PSNR=psnr(TX,Im); %psnr
         % SSIM=ssim(TX,Im); %ssim
           imname=['_k_',num2str(k), ...
               '_PSNR_',num2str(PSNR),  'Time=' num2str(time),'.mat'];
             save(imname,'TX','errList');  
   %      end
   end
end
