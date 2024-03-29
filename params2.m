format compact
format long

jeq = 1.24*10^(-3);
jp = 1.10*10^(-3);
m = 0.027;
l = 0.153;
r = 0.0826;
kf = 8.48*10^(-3);
ks = 0.028;
beq = 2.4*10^(-3);
bp = 2.4*10^(-3);
g = 9.8154;


k4 = (jeq+m*r^2)*(jp+m*l^2)-(m*r*l)^2;
k3 = (jeq+m*r^2)*bp + (jp+m*l^2)*(beq+kf*ks);
k2 = bp*(beq+kf*ks)+m*g*l*(jeq+m*r^2);
k1 = m*g*l*(beq+kf*ks);

jeqjep = (jeq+m*r^2)*(jp+m*l^2);
a_minusone = (1 - (m*r*l)^2/jeqjep)^-1;


a32 = -m*r*l*m*g*l*a_minusone/jeqjep;
a33 = (beq+kf*ks)*a_minusone/(jeq+m*r^2);
a34 = bp*m*r*l*a_minusone/jeqjep;
a42 = -m*g*l*a_minusone/(jp+m*l^2);
a43 = (beq+kf*ks)*m*r*l*a_minusone/jeqjep;
a44 = bp*a_minusone/(jp+m*l^2);

v3 = kf*a_minusone/(jeq+m*r^2);
v4 = kf*m*r*l*a_minusone/jeqjep;


A = [0 0 1 0
    0 0 0 1
    0 a32 a33 a34
    0 a42 a43 a44]

B = [0
    0
    v3
    v4]

C_u = [B A*B A^2*B A^3*B]
rg = rank(C_u)

C_u_inv = inv(C_u)
X_A=A^2+25*eye(size(A)) %Характерестичесй полином от А. коэффициенты вбиваем, какие хотим получить по желаемому характерестическому полиному!
e=[0 0 0 1];
Q_A=-e*C_u_inv*X_A
%% 

e = eig(A)
[V,D,W]=eig(A)
%% 

% W-столбцы являются соответствующими левыми 
%собственными векторами, D-на диагонали с.ч.

P_inv = [(W(:,4))';
    (W(:,1))';
    1 0 0 0;
    0 1 0 0]
P=inv(P_inv)

A_volna = P_inv*A*P
B_volna = P_inv*B

syms Q1 Q2
Tetha_cherta = [Q1 Q2 0 0]
A_volna_c = A_volna + B_volna*Tetha_cherta

%% 
syms lambda
A_q = [1.8644429777606017-5.404296344597642*Q1 5.404296344597642*Q2
        -2.810952353216602*Q1  2.810952353216602*Q2]

tmp=det(A_q-eye(size(A_q))*lambda)
vpa(tmp,8)

%% 
Tetha_cherta = [0.913558 0.381617 0 0]
Tetha = Tetha_cherta*P_inv
vpa(Tetha,7)
%% 
Tetha_cherta = [0.417992 64.45076 0 0]
Tetha = Tetha_cherta*P_inv

