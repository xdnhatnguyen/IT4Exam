x = 6;
x = x + 2;
clc
clear all
format long
disp('Máy tính tuổi thông minh!')
%Nhap: 
x = input('nhap so tuoi: ');
x + 6;
%Xuat:
disp(x);
%desp('van ban');
fprintf('Thật tuyệt vời, bạn %d tuổi', x);
subplot(3,3,1);
% x = start: step: end
x = 0:0.1:2*pi;
y = sin(x);
plot(x, y);
title('Đồ thị hàm răng');
xlabel('x values');
ylabel('sin(x)');
grid on; % bật lưới

x = -2*pi:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x + pi/4);
y3 = sin(x + pi/2);
%plot(x, y1, x, y2, x, y3);
y = [y1; y2; y3];
plot(x, y)
% giữ lại đồ thị cũ
hold on
x1 = 0:0.01:4;
%y4 = (x.^2); từng phần tử rời rạc * nhau: dùng .*
y4 = x1.^2;
plot(x, y4, '--ob');
x2 = linspace(-10, 10, 1000);
y5 = x2.^2 + 1;
%plot(x, y, 'trang trí');
%plot(x, y, '--sk'); %k: màu đen, b:blue, y: yellow, r: red, s: hình vuông

hold on
%plot(x2, y5, '-.^r')
plot(x2, y5, 'b--')% vẽ rất mịn

hold on

t = 0:pi/20:2*pi; [x,y] = meshgrid(t);
subplot(3,3,2) %Vẽ ở các phần nhỏ trong cùng 1 khung hình
%subllot(số dòng, số cột, vị trí)
plot(sin(t),cos(t))
axis equal
subplot(3,3,3) % hàm này yêu cầu vị trí hình vẽ
z = sin(x)+cos(y);
plot(t,z)
axis([0 2*pi -2 2])
subplot(3,3,4)
z = sin(x).*cos(y);
plot(t,z)
axis([0 2*pi -1 1])
subplot(3,3,5)
z = (sin(x).^2)-(cos(y).^2);
plot(t,z)
axis([0 2*pi -1 1])






