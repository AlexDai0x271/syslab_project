wp = 0.2*pi;
ws = 0.3*pi;
Rp=3
As=60
F = 10000
t = 0:0.1:2*pi
x = cos(t)
% 高/低通滤波器幅频/相频特性
[N,wc]=buttord(wp/pi,ws/pi,Rp,As)
img = imread('F:\syslab_project\matlab\matlab.bmp')
if size(img, 3)==3
    img = rgb2gray(img)
end
figure;
imshow(img)
title('Origin Image')

F = fft(double(img))
F_shifted = fftshift(F);
magnitude = abs(F_shifted)
figure
imshow(log(1+magnitude),[]);
title('magnitude Image')

[B, A]=butter(N,wc,'high')
[H,F]=freqz(B,A,F,1000)
F_filtered = filter(B,A,F_shifted)
F_inv = ifftshift(F_filtered)
img_real = real(ifft2(F_inv))

figure
imshow(img_real,[])
title('Image_high')
% figure;
% subplot(3,3,1)
% plot(F,20*log10(abs(H)))
% xlabel('频率/Hz')
% ylabel('增益/dB')
% title('高通滤波器幅频响应')
% subplot(3,3,2)
% plot(F,angle(H)*180/pi)
% xlabel('频率/Hz')
% ylabel('相位/rad')
% title('高通滤波器相频响应')
% subplot(3,3,3)
% y = filter(B,A,x)
% stem(t,y)


[B,A]=butter(N,wc)
[H,F]=freqz(B,A,F,1000)
F_filtered = filter(B,A,F_shifted)
F_inv = ifftshift(F_filtered)
img_real = real(ifft2(F_inv))

figure
imshow(img_real,[])
title('Image_low')
% subplot(3,3,4)
% plot(F,20*log10(abs(H)))
% xlabel('频率/Hz')
% ylabel('增益/dB')
% title('低通滤波器幅频响应')
% subplot(3,3,5)
% plot(F,angle(H)*180/pi)
% xlabel('频率/Hz')
% ylabel('相位/rad')
% title('低通滤波器相频响应')
% subplot(3,3,6)
% y = filter(B,A,x)
% stem(t,y)

% % 带通幅频相频响应
% wp = [0.2*pi,0.3*pi];
% ws = [0.5*pi,0.6*pi];
% [N,wc]=buttord(wp./pi,ws./pi,Rp,As)
% [B, A]=butter(N,wc)
% [H,F]=freqz(B,A,F,1000)
% subplot(3,3,7)
% plot(F,20*log10(abs(H)))
% xlabel('频率/Hz')
% ylabel('增益/dB')
% title('带通滤波器幅频响应')
% subplot(3,3,8)
% plot(F,angle(H)*180/pi)
% xlabel('频率/Hz')
% ylabel('相位/rad')
% title('带通滤波器相频响应')
% subplot(3,3,9)
% y = filter(B,A,x)
% stem(t,y)


img = imread('F:\syslab_project\matlab\matlab.bmp')
if size(img, 3)==3
    img = rgb2gray(img)
end
figure;
imshow(img)
title('Origin Image')

F = fft(double(img))
F_shifted = fftshift(F);
magnitude = abs(F_shifted)
figure
imshow(log(1+magnitude),[]);

F_filtered = filter(B,A,F_shifted)
F_inv = ifftshift(F_filtered)
img_real = real(ifft2(F_inv))

figure
imshow(img_real,[])