% syms bien1 bien2
% f = x^2;
% 
% limit(f, x, abs %lim (x -> a) của f(x)
% limit(f, x, a, 'left') %lim (x -> a-) của f(x)
% limit(f, x, a, 'right') %lim (x -> a+) của f(x)
% diff(f, x, n) % n là số cấp, mặc định = 1.
% int(f, x, a, b) % tích phân từ a -> b của f(x)

% ví dụ: 
syms x
f = (2 + exp(-x))/x
I = int(f, x, 1, Inf)


