format compact
syms x11 x12 x22 x1 x2

A= [0 1
    -1 0] 
X = [x11 x12
    x12 x22]

Q =[1 0
    0 1]
B=[0
    1]

C=sqrtm(Q)
%C=[1 0
%    0 1]
%% 

C_u = [B A*B A^2*B]
rg = rank(C_u)

% Построение матрицы наблюдаемости
Q_n = [C
    C*A
    C*A^2]
rg = rank(Q_n)

%% 

R=1/9

Q+A'*X+X*A-X*B*(R^(-1))*B'*X
tmp=care(A,B,Q,R)
%% 

x = [x1
    x2];

u=-R^(-1)*B'*tmp*x