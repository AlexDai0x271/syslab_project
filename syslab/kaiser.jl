import TySignalProcessing
using TySignalProcessing

# 滤波参数初始化
fp = 1500
fs = 2500
rs = 40
Fs = 10000

# 求 wp 和 ws
wp = 2 * π * fp / Fs
ws = 2 * π * fs / Fs
Bt = ws - wp

# 计算凯塞窗参数 alph
if rs < 21
    alph = 0
elseif rs > 21 && rs < 50
    alph = 0.5842 * (rs - 21)^0.4 + 0.07886 * (rs - 21)
elseif rs > 50
    alph = 0.112 * (rs - 8.7)
end

# 计算滤波器阶数 M
M = ceil((rs - 8) / (2.285 * Bt))
M = Int64(M)

# 计算 wc （对 pi 归一化）
wc = (wp + ws) / (2 * π)

# 设计滤波器
h_kaiser = fir1(M, wc, kaiser(M + 1, alph))

# 计算频率响应
H, F = freqz(h_kaiser, 1, 1024)


# 绘制滤波器频率响应
figure()
subplot(2, 1, 1)
plot(F, 20*log10.(abs.(H)))
xlabel("频率/Hz")
ylabel("增益/dB")
title("低通滤波器幅频响应")
grid("on")

subplot(2, 1, 2)
plot(F, angle.(H) * 180 / π)
xlabel("频率/Hz")
ylabel("相位/度")
title("低通滤波器相频响应")
grid("on")


# 生成测试信号
t = 0:1/Fs:2*π
x = cos.(2 * π * 1000 .* t)+0.5*cos.(2* π * 3000 .* t)

# 应用滤波器
y = filtfilt(h_kaiser, 1, x)


# 绘制滤波结果
figure()
subplot(2,1,1)
plot(t, x)
xlabel("时间 (s)")
ylabel("幅度")
title("原函数输出")
grid("on")
xlim([0 0.01])

subplot(2,1,2)
plot(t, y)
xlabel("时间 (s)")
ylabel("幅度")
title("低通滤波器输出")
grid("on")
xlim([0 0.01])
