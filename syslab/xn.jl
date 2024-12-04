using Interpolations
# 采样间隔参数
l1 = 0.1
l2 = 0.5

# 傅里叶系数
a_n = [0, 4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
b_n = [4/π, 0, 4/(3π), 0, 4/(5π), 0, 4/(7π), 0, 4/(9π)]
T0 = 2 * π
num_points = 1000

# 调用函数生成信号
x_t, t = func_generator(a_n, b_n, T0, num_points)

# 对 x(t) 采样
n1 = 0:l1:T0
x_n1_interp = LinearInterpolation(t, x_t)
x_n1 = x_n1_interp(n1)

n2 = 0:l2:T0
x_n2_interp = LinearInterpolation(t, x_t)
x_n2 = x_n2_interp(n2)

# 绘制 x(n)
figure()
subplot(2, 1, 1)
stem(n1, x_n1)
title("f1(n)")
xlabel("n")
grid("on")
subplot(2,1,2)
stem(n2, x_n2)
title("f2(n)")
xlabel("n")
grid("on")
