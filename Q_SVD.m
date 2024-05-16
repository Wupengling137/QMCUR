function [U,S,V] = Q_SVD(X)
%Input
%    X: a quaternion matrix 
%Output
% svd result
% created by Jifei Miao on 27/4/2020, jifmiao@163.com
    [A,B]=cd(X);   
    C=[A,B;-conj(B),conj(A)]; 
    [U1,S1,V1]=svd(C);
    S=S1(1:2:end,1:2:end);
    [m,~]=size(U1);
    [p,~]=size(V1);
   
    U11=U1(1:m/2,1:2:end);   U12=-conj(U1((m/2)+1:end,1:2:end));
    U111=real(U11);          U121=real(U12);
    U112=imag(U11);          U122=imag(U12);
                             [c,d]=size(U122);
                             U2=quaternion(U121,U122,zeros(c,d),zeros(c,d));
                             U2=U2*q2;
    
   U_1=quaternion(U111,U112,zeros(c,d),zeros(c,d));                          
   U=U_1+U2;
    
    V11=V1(1:p/2,1:2:end);   V12=-conj(V1((p/2)+1:end,1:2:end));
    V111=real(V11);          V121=real(V12);
    V112=imag(V11);          V122=imag(V12);
                             [s,m]=size(V122);
                             V2=quaternion(V121,V122,zeros(s,m),zeros(s,m));
                             V2=V2*q2;
    
   V_1=quaternion(V111,V112,zeros(s,m),zeros(s,m));  
   V=V_1+V2;