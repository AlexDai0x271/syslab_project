% 凯塞贝塞尔窗参数表
% alph      过渡带宽度      通带波纹        阻带最小衰减
% 2.120     3.00*pi/N      0.2700           -30
% 3.384     4.46*pi/N      0.0864           -40
% 4.538     5.86*pi/N      0.0274           -50
% 5.568     7.24*pi/N      0.0087           -60
% 6.764     8.64*pi/N      0.0028           -70

% 实现例7.2.2
% 对模拟信号进行低通滤波,通带0<=f<=1.5kHz内衰减低于1dB,阻带2.5kHz<=f<=inf内衰减大于40dB，
% 使用凯塞贝塞尔窗函数法完成滤波器设计，Fs=10kHz

% 滤波参数初始化
fp = 1500; % 通带截止频率 1.5kHz
fs = 2500; % 阻带截止频率 2.5kHz
rs = 40;   % 阻带最小衰减 40dB
Fs = 10000; % 采样频率 10kHz

% 求wp和ws
wp = 2*pi*fp/Fs;
ws = 2*pi*fs/Fs;
Bt = ws - wp;

% 计算凯塞窗参数 alph
if rs < 21
    alph = 0;
elseif rs > 21 && rs < 50
    alph = 0.5842 * (rs - 21)^0.4 + 0.07886 * (rs - 21);
else
    alph = 0.1102 * (rs - 8.7);
end

% 计算滤波器阶数 M
M = ceil((rs - 8) / (2.285 * Bt));

% 对pi归一化的截止频率
wc = (wp + ws) / (2 * pi);

% 设计FIR滤波器
amp = [1 1 0 0]    % 低通特性
freq = [0 wp ws pi]/pi   % 频率向量
hn = fir2(M, freq, amp, kaiser(M + 1, alph));       % 低通滤波器


% 频率响应
[H, F] = freqz(hn, 1, 1024, Fs);


% 绘制滤波器频率响应
figure;
subplot(2, 1, 1);
plot(F, 20*log10(abs(H)));
xlabel('频率/Hz');
ylabel('增益/dB');
title('使用凯赛窗滤波器幅频响应');
grid on;

subplot(2, 1, 2);
plot(F, angle(H) * 180 / pi);
xlabel('频率/Hz');
ylabel('相位/度');
title('使用凯赛窗滤波器相频响应');
grid on;


% 生成测试信号
t = 0:1/Fs:1; % 时间向量
x = cos(2*pi*1000*t) + 0.5*cos(2*pi*3000*t); % 1kHz和3kHz的正弦波

% 应用滤波器
y = filter(hn, 1, x);


% 绘制滤波结果
figure;
subplot(2, 1, 1);
plot(t, x);
xlabel('时间 (ms)');
ylabel('幅度');
title('原始信号');
grid on;
xlim([0 0.01])

subplot(2, 1, 2);
plot(t, y);
xlabel('时间 (ms)');
ylabel('幅度');
title('滤波后的信号');
grid on;
xlim([0 0.01])