import TySignalProcessing
using TySignalProcessing

fp = 100
fs = 200
Rp = 3
As = 60
Fs = 1000

wp = 2 * π * fp / (Fs/2)
ws = 2 * π * fs / (Fs/2)

t = 0:1/Fs:1
x = cos.(2* π *100 *t)+ 0.5*cos.(2* π* 300* t)

# 高通滤波器设计
N, wc = buttord(wp / π, ws / π, Rp, As)
b_high, a_high = butter(N, wc, "highpass")

# 低通滤波器设计
b_low, a_low = butter(N, wc)

# 计算频率响应
H_high, F_high = freqz(b_high, a_high, Fs)
H_low, F_low = freqz(b_low, a_low, Fs)

# 绘制高通滤波器幅频/相频响应
figure()
subplot(3,1,1)
plot(F_high, 20*log10.(abs.(H_high)))
title("高通滤波器幅频响应")
xlabel("频率/Hz")
ylabel("增益/dB")
grid("on")
subplot(3,1,2)
plot(F_high, angle.(H_high) * 180 / π)
title("高通滤波器相频响应")
xlabel("频率/Hz")
ylabel("相位/rad")
grid("on")
y_high = filtfilt(b_high, a_high, x)
subplot(3,1,3)
plot(t, y_high)
title("高通滤波器输出")
xlabel("时间")
ylabel("幅度")
grid("on")
xlim([0 0.01])

# 绘制低通滤波器幅频/相频响应
figure()
subplot(3,1,1)
plot(F_low, 20*log10.(abs.(H_low)))
title("低通滤波器幅频响应")
xlabel("频率/Hz")
ylabel("增益/dB")
grid("on")
subplot(3,1,2)
plot(F_low, angle.(H_low) * 180 / π)
title("低通滤波器相频响应")
xlabel("频率/Hz")
ylabel("相位/rad")
grid("on")
y_low = filtfilt(b_low, a_low, x)
subplot(3,1,3)
plot(t, y_low)
title("低通滤波器输出")
xlabel("时间")
ylabel("幅度")
grid("on")
xlim([0 0.01])

# # 带通滤波器设计
# wp_band = [0.2*π, 0.3*π]
# ws_band = [0.5*π, 0.6*π]
# N_band, wc_band = buttord(wp_band ./ π, ws_band ./ π, Rp, As)
# b_band, a_band = butter(N_band, wc_band, Bandpass(0.1, 0.5))

# # 计算频率响应
# H_band, F_band = freqz(b_band, a_band, Fs)

# # 绘制带通滤波器幅频/相频响应
# plot_layout_band = @layout [a b; c]

# p7 = plot(F_band, 20*log10.(abs.(H_band)), title="带通滤波器幅频响应", xlabel="频率/Hz", ylabel="增益/dB", grid=true)
# p8 = plot(F_band, angle.(H_band) * 180 / π, title="带通滤波器相频响应", xlabel="频率/Hz", ylabel="相位/rad", grid=true)
# y_band = filtfilt(b_band, a_band, x)
# p9 = plot(t, y_band, seriestype=:stem, title="带通滤波器输出", xlabel="时间", ylabel="幅度", grid=true)

# plot(p7, p8, p9, layout=plot_layout_band)
