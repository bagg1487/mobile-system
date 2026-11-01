
function Y = furye(x)
    N = length(x);
    Y = zeros(1, N);

    for k = 0:N-1
        for n = 0:N-1
            Y(k+1) = Y(k+1) + x(n+1)*exp(-1i*2*pi*k*n/N);
        end
    end
end

f = 4;
Fs = 132;
t = (0:Fs-1) / Fs;

y = sin(2*pi*f*t + pi/36) + sin(8*pi*f*t);

bits = [3 4 5 6];

Y = furye(y);
freq = (0:Fs-1) * Fs / length(y);
A = abs(Y) / length(y);

figure(1)
figure(2)

for i = 1:length(bits)
    b = bits(i);
    levels = 2^b;

    q = round((y+2)/4 * (levels-1));
    q = max(0, min(levels-1, q));
    yq = -2 + q*4/(levels-1);

    err = mean(abs(y-yq));
    fprintf('%d бит: средняя ошибка = %.6f\n', b, err);

    Yq = furye(yq);
    Aq = abs(Yq) / length(yq);

    figure(1)
    subplot(2, 2, i)
    plot(t, y, 'b')
    hold on
    stairs(t, yq, 'r')
    grid on
    xlabel('Время, с')
    ylabel('Амплитуда')
    title([num2str(b), ' бит'])
    legend('Исходный', 'Квантованный')

    figure(2)
    subplot(2, 2, i)
    plot(freq, A, 'b')
    hold on
    plot(freq, Aq, 'r')
    grid on
    xlabel('Частота, Гц')
    ylabel('Амплитуда')
    title([num2str(b), ' бит'])
    legend('Исходный', 'Квантованный')
end
