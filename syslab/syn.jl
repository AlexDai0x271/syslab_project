using TyPlot
using TyBase

# 定义傅里叶级数函数生成器
function func_generator(a_n::Vector{Float64}, b_n::Vector{Float64}, T0::Float64, num_points::Int)
    t = range(0, stop=T0, length=num_points)
    omega = 2 * π / T0
    x_t = zeros(num_points)

    if length(a_n) > 0
        a0 = a_n[1]
        x_t .= x_t .+ a0 / 2
    else
        a0 = 0
    end

    for n in 1:(length(a_n) - 1)
        an = a_n[n + 1]
        x_t .= x_t .+ an * cos.(n .* t .* omega)
    end

    for n in 1:length(b_n)
        bn = b_n[n]
        x_t .= x_t .+ bn * sin.(n .* t .* omega)
    end

    return x_t, t
end

# 采样间隔参数
l1 = 0.1
l2 = 1.0

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

# 进行 FFT
X_n1 = fft(x_n1)
X_n2 = fft(x_n2)

# 计算频率向量
f1 = (0:length(X_n1)-1) / (l1*length(X_n1))
f2 = (0:length(X_n2)-1) / (l2*length(X_n2))

# 绘制幅频特性
plot_layout = @layout [a; b]

p1 = plot(f1, abs(X_n1), title="采样间隔 T1 的幅频特性", xlabel="频率 f", ylabel="幅度", grid=true)
p2 = plot(f2, abs(X_n2), title="采样间隔 T2 的幅频特性", xlabel="频率 f", ylabel="幅度", grid=true)

plot(p1, p2, layout=plot_layout)

# 绘制相频特性
p3 = plot(f1, angle(X_n1), title="采样间隔 T1 的相频特性", xlabel="频率 f", ylabel="相位", grid=true)
p4 = plot(f2, angle(X_n2), title="采样间隔 T2 的相频特性", xlabel="频率 f", ylabel="相位", grid=true)

plot(p3, p4, layout=plot_layout)
