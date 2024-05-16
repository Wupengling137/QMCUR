function [X,TX, errList,Iter] = cur_length(T, Omega, opts)
maxIter = opts.maxIter;
con = opts.con; con2 = opts.con2;
% ranks = opts.r;
[n1, n2] = size(T); 
X  = vector(zerosq(n1,n2));
X(Omega) = T(Omega);
errList = zeros(maxIter, 1);
% Iteration Scheme
[m,n] = size(X);
siz_row = con;
siz_col = con2;
for Iter = 1: opts.maxIter
   Xk = X;
     %% update Z     \
    %  rows = randi(m,1,siz_row);
    % cols = randi(n,1,siz_col);
    % rows = unique(rows);
    % cols = unique(cols);
    % rows = randsample(m, siz_row);
    % cols = randsample(n, siz_col);
    normX = norm(X(:))^2;
    %% Update L = C * pinv_U * R
  [C,indexA ] = col_length(X,con,normX);
  [R,IndexR] = row_length(X,con2,normX);

    [UC, SC, VC ] = Q_SVD(C);
    pinvC = VC  * pinv(SC) * UC';
       [UR, SR, VR ] = Q_SVD(R);
    pinvR = VR  * pinv(SR) * UR';
    U = pinvC * X * pinvR;
    % W = C(IndexR,:);
    %  [Uw, Sw, Vw ] = Q_SVD(W);
    %  U = Vw * Sw * Uw';
    X = C * U * R;
 %% 更新X
    X=vector(X);%只要虚部，实部为0
    X(Omega)=T(Omega);
    
    X1 = max(part(X,2), 0);  X2 = max(part(X,3), 0);  X3 = max(part(X,4), 0); 
    TX(:,:,1)= X1 ;TX(:,:,2)= X2;TX(:,:,3)= X3;
    stopC = (norm(Xk(:) -X(:)))/  norm(Xk(:));
    errList(Iter) = stopC; 
    PSNR=psnr(TX,opts.XTrue); %psnr
    
    if mod(Iter, 1) == 0
         if isfield(opts, 'XTrue')
            fprintf('QM_CUR:  iter = %d   PSNR=%f resX=%f \n', Iter, PSNR,stopC);
         else
            fprintf('QM_CUR: iter = %d   res= %f  \n', Iter,stopC);
         end       
    end

    if stopC < opts.tol
        break;
    else

    end
errList = errList(1:Iter);
end