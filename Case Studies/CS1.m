%% ESE 351: Case Study 1
% * Names:                  Morgan Davies, Ouyang Du, & Elisabeth Belanger
% * Date:                   Created 2/27/2022


%[xv,xvfs] = audioread('roosevelt_noisy.wav'); len = 20;% 20 sec
%[xv,xvfs] = audioread('piano_noisy.wav'); len = 12; % 12 sec

%[xv,xvfs] = audioread('Blue in Green with Siren.wav'); 
%[xv,xvfs] = audioread('Space Station - Treble Cut.wav');  
[xv,xvfs] = audioread('Giant Steps Bass Cut.wav'); 

% 0 - unity, 1 - bass, 2 - treble
[g1, g2, g3, g4, g5] = presets(1);
y = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
[g1, g2, g3, g4, g5] = presets(2);
y2 = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
t = 0:length(xv)-1;
t = (1/xvfs)*t;



%% Space Station filtered
% g1 = 5; % 0 - 60
% g2 = 1; % 60 - 680
% g3 = 1; % 680 - 3320
% g4 = 1; % 3320 - 12680
% g5 = 1; % 12680+

[xv,xvfs] = audioread('Blue in Green with Siren.wav'); 
y = equilizer(xv(:, 1), xvfs, 10, 0, 0, 0, 0);
t = 0:length(xv)-1;
t = (1/xvfs)*t;

figure()
plot(t, y);
title('filtered');
figure()
plot(t, xv(:, 1));
title('original');
figure, spectrogram(y,1024,200,1024,xvfs)
soundsc(y, xvfs)
pause(15)
%soundsc(xv, xvfs)
figure, spectrogram(y,1024,200,1024,xvfs)
figure, spectrogram(xv(:, 1),1024,200,1024,xvfs)


%% Giant Steps filtered
% g1 = 5; % 0 - 60
% g2 = 1; % 60 - 680
% g3 = 1; % 680 - 3320
% g4 = 1; % 3320 - 12680
% g5 = 1; % 12680+

[xv,xvfs] = audioread('Giant Steps Bass Cut.wav'); 
y = equilizer(xv(:, 1), xvfs, 10, 0, 0, 0, 0);
t = 0:length(xv)-1;
t = (1/xvfs)*t;

figure()
plot(t, y);
title('filtered');
figure()
plot(t, xv(:, 1));
title('original');


soundsc(y, xvfs)
pause(15)
%soundsc(xv, xvfs)
figure, spectrogram(y,1024,200,1024,xvfs), title('filtered');
figure, spectrogram(xv(:, 1),1024,200,1024,xvfs), title('original');


%% Blue in Green filtered
% g1 = 5; % 0 - 60
% g2 = 1; % 60 - 680
% g3 = 1; % 680 - 3320
% g4 = 1; % 3320 - 12680
% g5 = 1; % 12680+

[xv,xvfs] = audioread('Blue in Green with Siren.wav'); 
y = equilizer(xv(:, 1), xvfs, 10, 0, 0, 0, 0);
t = 0:length(xv)-1;
t = (1/xvfs)*t;

figure()
plot(t, y);
title('filtered');
figure()
plot(t, xv(:, 1));
title('original');
soundsc(y, xvfs)
%pause(15)
%soundsc(xv, xvfs)
figure, spectrogram(y,1024,200,1024,xvfs)
figure, spectrogram(xv(:, 1),1024,200,1024,xvfs)


%% Frequency responses
% Low Pass TF
% lp_tf = tf([1],[1 1/tao]);

fc1 = 60;
tao1 = 1/(2*pi*fc1);
fs =xvfs;
% Low pass
x1 = filter((1/fs)/tao1, [1, (1/fs)/tao1-1], xv);
freqs([1],[1 1/tao1]);
%%
%--------------
fc2 = 680;
tao1 = 1/(2*pi*fc1);
tao2 = 1/(2*pi*fc2);
fs =xvfs;

% Low pass
x2 = filter((1/fs)/tao2, [1, (1/fs)/tao2-1], xv);
freqs([1],[1 1/tao2]);

% High pass
x2 = filter([1, -1], [(1+(1/fs)/tao2), -1], x2);
%---------------------
fc3 = 3320;
tao3 = 1/(2*pi*fc3);
fs =xvfs;

% Low pass
x3 = filter((1/fs)/tao3, [1, (1/fs)/tao3-1], xv);
freqs([1],[1 1/tao3]);

% High pass
x3 = filter([1, -1], [(1+(1/fs)/tao3), -1], x3);
%----------------------
fc4 = 12680;
tao4 = 1/(2*pi*fc4);
fs =xvfs;

% Low pass
x4 = filter((1/fs)/tao4, [1, (1/fs)/tao4-1], xv);
freqs([1],[1 1/tao4]);

% High pass
x4 = filter([1, -1], [(1+(1/fs)/tao3), -1], x4);

%------------------

% High pass
x5 = filter([1, -1], [(1+(1/fs)/tao4), -1], xv);

%% LSIM
% t = 0:0.001:15;
% W = 0:(size(t, 2)-1);
% 
% % h = 1/fs;
% % t = 0:h:5;
% % B = 1;
% % A = [1 + L*C/h^2 + R*C/h, -R*C/h -2*L*C/h^2, L*C/h^2];
% %s = jw 
% 
% y=lsim(1/(L*C),[1, R/L, 1/(L*C)], cos(pi*W(i).*t), t);
% figure()
% plot(W, 20*log(abs(y)))


