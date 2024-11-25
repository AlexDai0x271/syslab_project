function x_t = function_generator(a_n, b_n, T0, num_points)
    % 生成傅里叶级数展开的信号
    % a_n: 余弦项系数
    % b_n: 正弦项系数
    % T0: 信号的周期
    % num_points: 用于生成信号的时间点数

    t = linspace(0, T0, num_points);
    omega = 2 * pi / T0; 
    x_t = zeros(size(t));

    % 插入常数项
    if ~isempty(a_n)
        a0 = a_n(1);
        x_t = x_t + a0 / 2;
    else
        a0 = 0;
    end

    % 插入余弦项
    for n = 1:length(a_n)-1
        an = a_n(n+1);
        x_t = x_t + an * cos(n * t * omega);
    end

    % 插入正弦项
    for n = 1:length(b_n)
        bn = b_n(n);
        x_t = x_t + bn * sin(n * t * omega);
    end
end

% 测试函数
a_n = [0, 4/pi, 0, 4/(3*pi), 0, 4/(5*pi), 0, 4/(7*pi), 0, 4/(9*pi)];
b_n = [0, 4/pi, 0, 4/(3*pi), 0, 4/(5*pi), 0, 4/(7*pi), 0, 4/(9*pi)];
T0 = 2 * pi; % 周期
num_points = 1000; % 时间点数

% 调用函数生成信号
x_t = function_generator(a_n, b_n, T0, num_points);
t = linspace(0, T0, num_points);
% 绘制生成的信号
figure;
plot(t, x_t);
title('傅里叶级数生成的信号 x(t)');
xlabel('时间 t');
ylabel('幅度');
grid on;
