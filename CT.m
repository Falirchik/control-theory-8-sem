%% Построение матрицы управляемости
%меняем А и В под наши нужды
format rational
A = [0 -5 3 2
    3 14 -9 0
    5 18 -11 -1
    2 5 -3 0] 

B = [1
    1
    2
    1]

C = [2 2 -2 4]

C_u = [B A*B A^2*B A^3*B]
rg = rank(C_u)

% Построение матрицы наблюдаемости
Q = [C
    C*A
    C*A^2
    C*A^3]
rg = rank(Q)
%% ищем сч матрицы А
e = eig(A)
[V,D,W]=eig(A)
%% найдем образ матрицы
syms V1 V2 V3 V4 V5;
V = [V1
    V2
    V3
    V4];

C_u*V
%% Найдем ядро матрицы наблюдаемости
% количество векторов в ядре - размерность матрицы-ее ранг
Z = null(Q,'r')
%% Собираем Т
% T = [T1 T2 T3 T4]
% Т2 - пересечение образа и ядра
% T1 - дополнение до базиса в образе матрицы управления (базис образа равен
% рангу матрицы)
% Т4 - дополнение до базиса ядра матрицы наблюдаемости
% Т3 - если нужен, просто дополнение до нужной размерности
T = [0 -1 1 0
    1 -1 0 1
    1 0 0 0
    0 1 0 0]
T_inv = inv(T)
A_volna = T_inv*A*T
B_volna = T_inv*B
C_volna = C*T
%% проверка на стабилизируемость неуправляемой части 
%копировать неуправляемую часть матрицы
S_UnP= [-1 -1
    1 -1];
p_UnP=poly(S_UnP);
r=roots(p_UnP)
