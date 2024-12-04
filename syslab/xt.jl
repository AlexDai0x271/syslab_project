using TyPlot
function function_generator(a_n::Vector{Float64}, b_n::Vector{Float64}, T0::Float64, num_points::Int)
    # 生成傅里叶级数展开的信号
    # a_n: 余弦项系数
    # b_n: 正弦项系数
    # T0: 信号的周期
    # num_points: 用于生成信号的时间点数

    t = range(0, stop=T0, length=num_points)
    omega = 2 * π / T0
    x_t = zeros(num_points)

    # 插入常数项
    if length(a_n) > 0
        a0 = a_n[1]
        x_t .= x_t .+ a0 / 2
    else
        a0 = 0
    end

    # 插入余弦项
    for n in 1:(length(a_n) - 1)
        an = a_n[n + 1]
        x_t .= x_t .+ an * cos.(n .* t .* omega)
    end

    # 插入正弦项
    for n in 1:length(b_n)
        bn = b_n[n]
        x_t .= x_t .+ bn * sin.(n .* t .* omega)
    end

    return x_t, t
end

# 测试函数
a_n = [0, 4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
b_n = [0, 4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
T0 = 2 * π  # 周期
num_points = 1000  # 时间点数

# 调用函数生成信号
x_t, t = function_generator(a_n, b_n, T0, num_points)

# 绘制生成的信号
plot(t, x_t, title="傅里叶级数生成的信号 x(t)", xlabel="时间 t", ylabel="幅度", grid=true)
