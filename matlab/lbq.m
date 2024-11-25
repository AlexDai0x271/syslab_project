% 巴特沃斯滤波器
% nyquist截止频率为f/2,归一化后是0.5,那么截止频率就要在网fs=500hz以下
[b_low, a_low] = butter(4, 400/1000); 
[b_high, a_high] = butter(4, 400/1000, 'high'); 

x_n1_low_filtered = filter(b_low, a_low, x_n1);
x_n2_low_filtered = filter(b_low, a_low, x_n2);
x_n1_high_filtered = filter(b_high, a_high, x_n1);
x_n2_high_filtered = filter(b_high, a_high, x_n2);

% 绘制滤波结果
figure;
subplot(2,2,1);
stem(n1, x_n1_low_filtered, 'filled');
title('低通滤波后 T1 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;

subplot(2,2,2);
stem(n2, x_n2_low_filtered, 'filled');
title('低通滤波后 T2 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;

subplot(2,2,3);
stem(n1, x_n1_high_filtered, 'filled');
title('高通滤波后 T1 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;

subplot(2,2,4);
stem(n2, x_n2_high_filtered, 'filled');
title('高通滤波后 T2 的 x(n)');
xlabel('采样点 n');
ylabel('幅度');
grid on;
