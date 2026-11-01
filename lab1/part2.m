function Y = furye(x)
    N = length(x);
    Y = zeros(1, N);

    for k = 0:N-1
        for n = 0:N-1
            Y(k+1) = Y(k+1) + x(n+1) * exp(-1i*2*pi*k*n/N);
        end
    end
end

[y, Fs] = audioread('voice.wav');

N = length(y);
T = N / Fs;

zvuk = audioplayer(y, Fs);
play(zvuk);
pause(T);
stop(zvuk);

y1 = downsample(y, 10);

zvuk = audioplayer(y1, Fs/10);
pause(T);
play(zvuk);
pause(T);
stop(zvuk);

figure
subplot(2, 1, 1)
plot(y)
grid on
xlabel('Номер отсчёта')
ylabel('Амплитуда')
title('Исходный голос')

subplot(2, 1, 2)
plot(y1)
grid on
xlabel('Номер отсчёта')
ylabel('Амплитуда')
title('Голос после прореживания')

N1 = min(4096, length(y));
N2 = min(4096, length(y1));

Y1 = furye(y(1:N1));
Y2 = furye(y1(1:N2));

f1 = (0:N1-1) * Fs / N1;
f2 = (0:N2-1) * (Fs/10) / N2;

A1 = abs(Y1) / N1;
A2 = abs(Y2) / N2;

figure
subplot(2, 1, 1)
plot(f1, A1)
grid on
xlabel('Частота, Гц')
ylabel('Амплитуда')
title('Полный спектр исходного голоса')

subplot(2, 1, 2)
plot(f2, A2)
grid on
xlabel('Частота, Гц')
ylabel('Амплитуда')
title('Полный спектр прореженного голоса')

