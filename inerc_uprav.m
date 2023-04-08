% задаем время отрисовки графиков
TIME = 10.0;
% задаем ко-во точек, в которых нужно вычислять решение системы
count = 201;

A= [0 1 0
    -1 0 1
    0 0 0] 

Q =[1 0 0 
    0 1 0
    0 0 1]
B=[0
    0
    1]

nx = size(A, 1);
nu = size(B, 2);

R=1;
% находим стабилизирующий регулятор
[~, ~, G] = care(A, B, Q,R);   
    
% задаем параметры метода решения системы дифференциальных уравнений
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-5 * ones(1, nx));
% задаем начальные условия 
X0 = zeros(1, nx);   
X0(1) = 0.2;
    
% находим решение замкнутой линейной системы
[tticks_ideal, xticks_ideal] = ode45(@(t, X)((A - B * G) * X), ...
    linspace(0, TIME, count), X0, options);     
% вычисляем управление
uticks_ideal = zeros(1, count);
for k = 1 : count
    uticks_ideal(k) = -G * xticks_ideal(k, :)';
end 

nx = size(A, 1);
nu = size(B, 2);

% находим стабилизирующий регулятор
[~, ~, G] = care(A, B, Q);    
    
% задаем параметры метода решения системы дифференциальных уравнений
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-5 * ones(1, nx));
% задаем начальные условия 
X0 = zeros(1, nx);   
X0(1) = 0.6;
    
% находим решение замкнутой линейной системы
[tticks_inertia, xticks_inertia] = ode45(@(t, X)((A - B * G) * X), ...
    linspace(0, TIME, count), X0, options);

    % --------------------------------------------------------------------
	% СТРОИМ ГРАФИКИ РЕШЕНИЙ
    % --------------------------------------------------------------------  

    fhandle = figure;
    subplot(3, 1, 1)
        plot(tticks_ideal, xticks_ideal(:, 1), 'b', ...
             tticks_ideal, xticks_inertia(:, 1), 'r', 'LineWidth', 2.0)
        grid on;
        legend('безинерционный регулятор', 'инерционный регулятор');
        xlabel('t', 'FontSize', 12, 'FontWeight', 'bold');
        ylabel('x_1(t)', 'FontSize', 12, 'FontWeight', 'bold');
        title(sprintf('x_1^0 = %0.3f', X0(1)));
    subplot(3, 1, 2)
        plot(tticks_ideal, xticks_ideal(:, 2), 'b', ...
             tticks_ideal, xticks_inertia(:, 2), 'r', 'LineWidth', 2.0)
        grid on;
        legend('безинерционный регулятор', 'инерционный регулятор');
        xlabel('t', 'FontSize', 12, 'FontWeight', 'bold');
        ylabel('x_2(t)', 'FontSize', 12, 'FontWeight', 'bold');
        title(sprintf('x_2^0 = %0.3f', X0(2)));        
    subplot(3, 1, 3)
        plot(tticks_ideal, uticks_ideal, 'b', ...
             tticks_ideal, xticks_inertia(:, 3), 'r', 'LineWidth', 2.0)   
        grid on;
        legend('безинерционный регулятор', 'инерционный регулятор');
        xlabel('t', 'FontSize', 12, 'FontWeight', 'bold');
        ylabel('u(t)', 'FontSize', 12, 'FontWeight', 'bold');
        title(sprintf('x_3^0 = %0.3f', X0(3)));        
        

