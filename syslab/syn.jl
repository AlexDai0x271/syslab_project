l1 = 0.1
l2 = 0.5

# 进行 FFT
X_n1 = fft(x_n1)
X_n2 = fft(x_n2)

# 计算频率向量
f1 = (0:length(X_n1)-1) / (l1*length(X_n1))
f2 = (0:length(X_n2)-1) / (l2*length(X_n2))

# 绘制幅频特性
figure()
subplot(2,2,1)
stem(f1, abs.(X_n1))
title("采样间隔 T1 的幅频特性")
xlabel("频率 f")
ylabel("幅度")
grid("on")

subplot(2,2,2)
stem(f2, abs.(X_n2))
title("采样间隔 T2 的幅频特性") 
xlabel("频率 f")
ylabel("幅度")
grid("on")

# 绘制相频特性
subplot(2,2,3)
stem(f1, angle.(X_n1))
title("采样间隔 T1 的相频特性")
xlabel("频率 f")
ylabel("相位")
grid("on")

subplot(2,2,4)
stem(f2, angle.(X_n2))
title("采样间隔 T2 的相频特性")
xlabel("频率 f")
ylabel("相位")
grid("on")
