% 采样间隔参数
l1 = 0.1;
l2 = 1.0;

% 对x(t)采样，
n1 = 0:l1:T0;
x_n1 = interp1(t, x_t, n1);

n2 = 0:l2:T0;
x_n2 = interp1(t, x_t, n2);

% 绘制 x(n)
figure;
subplot(2,1,1);
stem(n1, x_n1, 'filled');
title('采样间隔 T1 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;

subplot(2,1,2);
stem(n2, x_n2, 'filled');
title('采样间隔 T2 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;
