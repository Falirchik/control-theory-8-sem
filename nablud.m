%% Построение матрицы управляемости
%меняем А и В под наши нужды
format rational
A = [-1 -1 0
    1 -1 0
    2 -2 1] 

C = [0 1 -1]

% Построение матрицы наблюдаемости
Q = [C
    C*A
    C*A^2]
rg = rank(Q)
%% ищем сч матрицы А
p_UnP=poly(A);
r=roots(p_UnP)
%% 
S_UnP= [1 0
    -2 -1];
p_UnP=poly(S_UnP);
r=roots(p_UnP)

%% ищем правый собственный вектор
% лямбда тот, КОТОРЫЙ ДВИГАЕМ
syms alpha betta gamma
lambda = 1
A-lambda*eye(size(A))
V_pr = [alpha
    betta
    gamma]
(A-lambda*eye(size(A))) * V_pr


%% P = [V_pr а тут достраиваем до нужной размерности столбики]
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
%% 
Q_trans = Q';
Q_inv=inv(Q_trans);
A_trans=A';
X_A=A_trans^3+6*A_trans^2+11*A_trans+6*eye(size(A)) %Характерестичесй полином от А. коэффициенты вбиваем, какие хотим получить по желаемому характерестическому полиному!
e=[0 0 1];
Q_A=-e*Q_inv*X_A


