using DSP, Plots

# 定义巴特沃斯滤波器函数
function butter_filter(order, cutoff, fs, filter_type)
    nyquist = fs / 2
    normalized_cutoff = cutoff / nyquist
    if filter_type == "low"
        return DSP.Filters.butter(order, normalized_cutoff, Lowpass())
    elseif filter_type == "high"
        return DSP.Filters.butter(order, normalized_cutoff, Highpass())
    else
        error("Unsupported filter type")
    end
end

# 采样间隔参数
l1 = 0.1
l2 = 1.0
fs = 1 / l1  # 采样频率

# 傅里叶系数
a_n = [0, 4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
b_n = [4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
T0 = 2 * π
num_points = 1000

# 调用函数生成信号
x_t, t = func_generator(a_n, b_n, T0, num_points)

# 对 x(t) 采样
n1 = 0:l1:T0
n2 = 0:l2:T0

x_n1_interp = LinearInterpolation(t, x_t)
x_n1 = x_n1_interp(n1)

x_n2_interp = LinearInterpolation(t, x_t)
x_n2 = x_n2_interp(n2)

# 定义巴特沃斯滤波器
b_low = butter_filter(4, 400, fs, "low")
b_high = butter_filter(4, 400, fs, "high")

# 应用滤波器
x_n1_low_filtered = filtfilt(b_low, x_n1)
x_n2_low_filtered = filtfilt(b_low, x_n2)
x_n1_high_filtered = filtfilt(b_high, x_n1)
x_n2_high_filtered = filtfilt(b_high, x_n2)

# 绘制滤波结果
plot_layout = @layout [a b; c d]

p1 = plot(n1, x_n1_low_filtered, seriestype=:stem, title="低通滤波后 T1 的 x(n)", xlabel="采样点 n", ylabel="幅度", grid=true)
p2 = plot(n2, x_n2_low_filtered, seriestype=:stem, title="低通滤波后 T2 的 x(n)", xlabel="采样点 n", ylabel="幅度", grid=true)
p3 = plot(n1, x_n1_high_filtered, seriestype=:stem, title="高通滤波后 T1 的 x(n)", xlabel="采样点 n", ylabel="幅度", grid=true)
p4 = plot(n2, x_n2_high_filtered, seriestype=:stem, title="高通滤波后 T2 的 x(n)", xlabel="采样点 n", ylabel="幅度", grid=true)

plot(p1, p2, p3, p4, layout=plot_layout)
