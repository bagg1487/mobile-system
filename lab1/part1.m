function Y = furye(x)
    N = length(x);
    Y = zeros(1, N);

    for k = 0:N-1
        for n = 0:N-1
            Y(k+1) = Y(k+1) + x(n+1) * exp(-1i * 2*pi*k*n/N);
        end
    end
end

f = 4;
y = @(t) sin(2*pi*f*t + pi/36) + sin(8*pi*f*t);
t0 = 0:0.001:1;

f_kotel = 33;
t1 = (0:f_kotel-1) / f_kotel;
y1 = y(t1);

f2 = f_kotel * 4;
t2 = (0:f2-1) / f2;
y2 = y(t2);

figure

subplot(2, 1, 1)
plot(t0, y(t0), 'b')
hold on
plot(t1, y1, 'r-o')
grid on
xlabel('Время, с')
ylabel('Амплитуда')
title('Дискретизация 33 Гц')
legend('Исходный', 'По отсчетам')

subplot(2, 1, 2)
plot(t0, y(t0), 'b')
hold on
plot(t2, y2, 'r-')
grid on
xlabel('Время, с')
ylabel('Амплитуда')
title('Дискретизация 132 Гц')
legend('Исходный', 'По отсчетам')

Y1 = furye(y1);
Y2 = furye(y2);

N1 = length(Y1);
N2 = length(Y2);

k1 = 0:N1-1;
k2 = 0:N2-1;

freq1 = k1 * f_kotel / N1;
freq2 = k2 * f2 / N2;

A1 = abs(Y1) / N1;
A2 = abs(Y2) / N2;

figure

subplot(2, 1, 1)
stem(freq1, A1)
grid on
xlabel('Частота, Гц')
ylabel('Амплитуда')
title('Спектр 33 Гц')

subplot(2, 1, 2)
stem(freq2, A2)
grid on
xlabel('Частота, Гц')
ylabel('Амплитуда')
title('Спектр 132 Гц')


