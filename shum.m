format compact
format rational
syms x1 x2;

C =[1 -1
    1 1]
C_r = [C
    C
    C];
tmp=inv(C_r'*C_r)
y1 = [4.41 0.97]';
y2=[4.43 0.39]';
y3=[5.20 -1.03]';
y=[y1
    y2
    y3];
tmp1 = C'*y1;
tmp2 = C'*y2;
tmp3 = C'*y3;

x_domic = tmp*(tmp1+tmp2+tmp3);
vpa(x_domic,6)
%% 
Xk = [0.6931 1.0986 1.3863 1.6094 1.7918]
Yk= [0.4055 1.0986 1.5041 1.9459 2.1401]

syms a b c
vpa(Yk',6)
e = [1 1 1 1 1]
tmp = vpa([(Xk').^2 Xk' e']*([a b c]'),6);

A=[(Xk').^2 Xk' e'];
C=A;
vpa(A,6)
vpa(A\Yk',6)
vpa((inv((A')*A))*(A')*(Yk'),6) 
% вот то, что выше - работает с вырожденными
%% 
vpa(inv(C'*C),6)
tmp = vpa((inv(C'*C)*C')*Yk',6)
%% 
C0=C(1:3,1:3);
vpa(C0,6)
H0 = C0'*C0;
vpa(H0,6)
abc0=inv((C0)'*(C0))*(C0')*Yk(1:3)';
vpa(abc0,6)

%% 
tmp = A(4,1:3);

H1 = H0+tmp'*tmp;
vpa(H1,6)
tmp=inv(H1)*tmp'*(1.9459-abc0*tmp);
abc1=abc0+tmp;
vpa(abc1,6)
%% 

