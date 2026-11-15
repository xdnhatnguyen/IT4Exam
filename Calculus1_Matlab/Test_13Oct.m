clc % xoa man hinh
clear all
close all
format long
% Ho va ten: Nguyen Minh Nhat 
% Lop: 25CTT3B
% A = sqrt(144)
% B = 5.24*5
% C = 144^(1/3)
% % Ham luong giac: dung radian
% % pi, NaN, inf/Inf, phan biet hoa thuong
% % phep giao, hop
% % lingoes translator
% % control R: chu thich, nguoc lai: Ctrl T
% % D = (1 > 2) && (2 < 4)
% % viet chuong trinh nhap chieu dai, rong hcn -> dien tich
% a = input('Nhap chieu dai: ');
% b = input('Nhap chieu rong: ');
% S = a*b;
% % disp('Dien tich: ');
% % disp(S)
% fprintf('Dien tich: %.9f\n', S) % %.9f = S - 9 so thap phan sau dau phay
% 
% c = input('Nhap phonggay: ');
% d = input('Nhap phonggey: ');
% % So sanh c va d:
% if (c > d)
%     fprintf('c lon hon d');
% elseif (c == d)
%     fprintf('c bang d');
% else 
%     fprintf('c be hon d');
% end
n = input('Nhap n (n nguyen duong): ');
while (n <= 0)
    n = input('Khong thoa man, nhap lai n : ');
end
s = 0;
for i = 1: n
    s = s + i;
end
fprintf('tong s = %2.5g\n', s);
%%
% ... va ;
% $$e^{\pi i} + 1 = 0$$
% 
