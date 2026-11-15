clc
clear all
fplot(@(x) x.^2, [-10, 10], 'r-', 'LineWidth',2);
grid on;
title('Plot of the function f(x) = x^2');
xlabel('x');
ylabel('f(x)');
legend("Hàm x^2", 'Location', 'NorthWest');

