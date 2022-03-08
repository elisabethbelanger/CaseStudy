function y=equalizer2(input, R1, R2, R3, R4, R5)

L = 1000; % Inductance in Henries
w = 0:20000/size(input,1):20000;
w = w(1:end-1);
% 60 Hz
w1=2*pi*60;
C = 1/(w1^2*L);  % Capacitance in Farads
B_s = 1/(L*C);
A_s = [1 ((120*L/(2*pi))^2/(2*L^2)) 1/(L*C)];
y1 = freqs(B_s, A_s, w);

% 400 Hz
w2=2*pi*400;
C = 1/(w2^2*L);
B_s = [1/(L*C)];
A_s = [1 (560*L/(2*pi))^2/(2*L^2) 1/(L*C)];
y2=freqs(B_s, A_s, w);

% 2000 Hz
w3=2*pi*2000;
C = 1/(w3^2*L);
B_s = [1/(L*C)];
A_s = [1 ((2640*L/(2*pi))^2/(2*L^2)) 1/(L*C)];
y3=freqs(B_s, A_s, w);

% 8 kHz
w4=2*pi*8000;
C = 1/(w4^2*L);
B_s = [1/(L*C)];
A_s = [1 ((9360*L/(2*pi))^2/(2*L^2)) 1/(L*C)];
y4=freqs(B_s, A_s, w);

% 14 kHz
w5=2*pi*14000;
C = 1/(w5^2*L);
B_s = [1/(L*C)];
A_s = [1 ((2640*L)/(2*pi))^2/(2*L^2) 1/(L*C)];
y5=freqs(B_s, A_s, w);

%H1 = (R1/max(y1))*y1 + (R2/max(y2))*y2 + (R3/max(y3))*y3 + (R4/max(y4))*y4 + (R5/max(y5))*y5;

%Y1=fft(input').*H1;


% 400 Hz
w2=2*pi*400;
C = 1/(w2^2*L);
B_s = [0 0 1/(L*C)];
A_s = [1 (560*L/(2*pi))^2/(2*L^2) 1/(L*C)];
y6=freqs(B_s, A_s, w);

% 2000 Hz
w3=2*pi*2000;
C = 1/(w3^2*L);
B_s = [1/(L*C) 0 0];
A_s = [1 ((2640*L/(2*pi))^2/(2*L^2)) 1/(L*C)];
y7=freqs(B_s, A_s, w);

% 8 kHz
w4=2*pi*8000;
C = 1/(w4^2*L);
B_s = [0 0 1/(L*C)];
A_s = [1 ((9360*L/(2*pi))^2/(2*L^2)) 1/(L*C)];
y8=freqs(B_s, A_s, w);

u1=(abs(y3)/max(abs(y3)));
u2=(abs(y7)/max(abs(y7)));

figure()
hold on
plot(w, abs(y3)/max(abs(y3)))
plot(w, abs(y7)/max(abs(y7)))
plot(w, u1.*u2)
hold off


% 14 kHz
w5=2*pi*14000;
C = 1/(w5^2*L);
B_s = [0 0 1/(L*C)];
A_s = [1 ((2640*L)/(2*pi))^2/(2*L^2) 1/(L*C)];
y9=freqs(B_s, A_s, w);

H2 = (R2/max(y6))*y6 + (R3/max(y7))*y7 + (R4/max(y8))*y8 + (R5/max(y9))*y9;

Y2=fft(input').*H2;

Y = Y1.*Y2;

y = ifft(Y);

end