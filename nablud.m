%% Построение матрицы управляемости
%меняем А и В под наши нужды
format rational
A = [0 1 0
     4 0 0
     0 -1 -1] 

C = [1 0 0]

% Построение матрицы наблюдаемости
Q = [C
    C*A
    C*A^2]
rg = rank(Q)
%% ищем сч матрицы А
p_UnP=poly(A);
r=roots(p_UnP)
%% ищем правый собственный вектор
A_ = [-2 1 0
    4 -2 0
    0 -1 -3]
[V,D] = eig(A_)


%% 
P = [3 0 1
    6 1 0
    -2 0 0]
P_inv=inv(P)
A_domik = P_inv*A*P
C_domik = C*P
%% 
syms Q;
L_domik = [Q
           0
           0]
A_c = A_domik - L_domik*C_domik
%%
L_domik = [2
    0
    0]
L = P*L_domik
%% 
A_c = A -L*C
p_UnP=poly(A_c);
r=roots(p_UnP)